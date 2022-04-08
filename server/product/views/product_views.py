
from datetime import datetime
from django.core.files.base import ContentFile
import base64
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from product.serializers.product_serializer import *
from users.serializers.user_serializer import *
from ..models import *


@api_view(["GET"])
def get_products(request):
    products = ProductModel.objects.all()
    serializer = ProductModelSerializer(products, many=True)
    return Response(serializer.data)


@api_view(["GET"])
def get_product(request, barcode):
    try:
        product = ProductModel.objects.get(barcode=barcode)
        serialized = ProductModelSerializer(product, many=False)
        return Response(serialized.data)
    except:
        return Response({"error": "product does not exist"})


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def add_product(request):
    print(request.data)
    data = request.data
    cat_name = request.data["category"]
    category = CategoryModel.objects.get_or_create(cat_name=cat_name)
    form_data = {
        **data, "category": category[0].id
    }
    data = form_data

    serializer = ProductModelSerializer(data=data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors)


@api_view(["GET"])
def get_product_by_category(request, category):
    product = ProductModel.objects.filter(
        category__cat_name=category
    )
    serializer = ProductModelSerializer(product, many=True)
    return Response(serializer.data)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def add_item(request):
    data = request.data
    print(request.data)
    try:
        product = ProductModel.objects.get(barcode=data["barcode"])
        ItemModel.objects.create(
            user_id=request.user.id, product_id=product.id,
            expiry_date=data["expiry_date"], purchased_date=data["purchased_date"]
        )

        return Response(status=status.HTTP_201_CREATED)
    except Exception as ex:
        raise ex
    # except:
    #     return Response(status=status.HTTP_400_BAD_REQUEST)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def get_items(request):
    try:
        user = UserModel.objects.get(id=request.user.id)
        items = ItemModel.objects.filter(user=user)
        serializer = ItemModelSerializer(items, many=True)
        print(serializer.data)
        return Response(serializer.data, status=status.HTTP_200_OK)
    # except:
    #     return Response(status=status.HTTP_404_NOT_FOUND)
    except Exception as ex:
        raise ex


@api_view(["DELETE"])
@permission_classes([IsAuthenticated])
def remove_item(request, item_id):
    try:
        item = ItemModel.objects.get(id=item_id)
        item.delete()
        return Response(status=status.HTTP_200_OK)
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def add_food(request):
    try:
        data = request.data
        user = UserModel.objects.get(id=request.user.id)
        cat_name = request.data["category"]
        file = data["file"]
        name = data["image_name"]
        image_file = ContentFile(base64.b64decode(file), name)
        category = CategoryModel.objects.get_or_create(cat_name=cat_name)
        form_data = {
            **data, "user": user.id, "category": category[0].id, "image": image_file
        }
        data = form_data
        serializer = FoodSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors)
    except Exception as ex:
        raise ex


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def get_foods(request):
    try:
        user = UserModel.objects.get(id=request.user.id)
        today_date = datetime.now()
        items = Food.objects.filter(user=user).filter(
            expiry_date__range=[today_date, '2023-01-01'])
        serializer = FoodSerializer(items, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    # except:
    #     return Response(status=status.HTTP_404_NOT_FOUND)
    except Exception as ex:
        raise ex


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def get_recend_foods(request):
    try:
        user = UserModel.objects.get(id=request.user.id)
        today_date = datetime.now()
        last_food = Food.objects.filter(user=user).filter(
            expiry_date__range=[today_date, '2023-01-01']).order_by(
            '-id')[:3]
        last_food_ascending = reversed(last_food)
        serializer = FoodSerializer(last_food_ascending, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except Exception as ex:
        raise ex


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def get_expired_foods(request):
    try:
        user = UserModel.objects.get(id=request.user.id)
        end_date = datetime.now()
        expired_foods = Food.objects.filter(user=user).filter(
            expiry_date__range=["2022-01-01", end_date])
        serializer = FoodSerializer(expired_foods, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    except Exception as ex:
        raise ex


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def get_foods_by_category(request, category):
    food = Food.objects.filter(
        category__cat_name=category
    )
    serializer = FoodSerializer(food, many=True)
    return Response(serializer.data)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def remove_food(request, food_id):
    try:
        food = Food.objects.get(id=food_id)
        food.delete()
        return Response(status=status.HTTP_200_OK)
    # except:
    #     return Response(status=status.HTTP_404_NOT_FOUND)
    except Exception as ex:
        raise ex


@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def increase_quantity(request, food_id):
    try:
        food = Food.objects.get(id=food_id)
        food.total += 1
        # food.quantity = food.total * int(food.quantity)
        food.save()
        return Response(status=status.HTTP_200_OK)
    except Exception as ex:
        raise ex


@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def decrease_quantity(request, food_id):
    try:
        food = Food.objects.get(id=food_id)
        food.total -= 1
        # food.quantity = food.total * int(food.quantity)
        food.save()

        if food.total <= 0:
            food.delete()
        return Response(status=status.HTTP_200_OK)
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)
