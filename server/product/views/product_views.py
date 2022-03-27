

from rest_framework.response import Response 
from rest_framework.decorators import api_view , permission_classes
from rest_framework.permissions import IsAuthenticated
from product.serializers.product_serializer import *
from api.serializers.user_serializer import *
from rest_framework import status
from ..models import *


@api_view(['GET'])
def get_products(request):
    products = ProductModel.objects.all()
    serializer = ProductModelSerializer(products, many= True)
    return Response(serializer.data)

@api_view(['GET'])
def get_product(request, barcode):
    product = ProductModel.objects.get(barcode = barcode)
    serialized = ProductModelSerializer(product, many=False)
    return Response(serialized.data)

@api_view(['POST'])
def add_product(request):
    data = request.data
    serializer = ProductModelSerializer(data=data)
    if serializer.is_valid():
        serializer.save()
        return Response({"status": "success"})
    return Response({"error" :"failed to add product"})
    

@api_view(['GET'])
def get_product_by_category(request, category):
    product = ProductModel.objects.filter(
        category__cat_name = category
    )
    serializer = ProductModelSerializer(product, many = True)
    return Response(serializer.data)
      

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def add_item(request):
    data = request.data
    user = UserModel.objects.get(id = request.user.id)
    product = ProductModel.objects.get(id = data["product_id"])

    try:
        items = ItemModel.objects.filter(user = user)
        total_items = items.count()
        if total_items == 0:
            ItemModel.objects.create(
            user = user, product = product, company_name = data['company_name'],item_total= product.product_quantity,
            quantity = 1, expiry_date = data['expiry_date'], purchased_date= data['purchased_date']
            )
        else:
            for item in items:
                if item.product.product_name == product.product_name:
                    item.quantity += 1
                    item.item_total = item.quantity * item.product.product_quantity
                    item.save()
                    return Response(status=status.HTTP_200_OK)
            ItemModel.objects.create(
            user = user, product = product, company_name = data['company_name'],item_total= product.product_quantity,
            quantity = 1, expiry_date = data['expiry_date'], purchased_date= data['purchased_date']
            )
    except:
         return Response(status=status.HTTP_404_NOT_FOUND)



@api_view(["GET"])
@permission_classes([IsAuthenticated])
def get_items(request):
    try:
        user = UserModel.objects.get(id = request.user.id)
        items = ItemModel.objects.filter(user= user)
        serializer = ItemModelSerializer(items , many = True)
        return Response(serializer.data , status=status.HTTP_200_OK)
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)




@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def increase_quantity(request, item_id):
    try:
        item = ItemModel.objects.get(id=item_id)
        item.quantity += 1
        item.item_total = item.quantity * item.product.product_quantity
        item.save()
        return Response(status=status.HTTP_200_OK)
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)


@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def decrease_quantity(request, item_id):
    try:
        item = ItemModel.objects.get(id=item_id)
        item.quantity -= 1
        item.item_total = item.quantity * item.product.product_quantity
        item.save()

        if item.quantity <= 0:
            item.delete()
        return Response(status=status.HTTP_200_OK)
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)