

from unicodedata import category
from django.http import JsonResponse
from rest_framework.response import Response
from rest_framework.decorators import api_view
from product.serializers.product_serializer import *
from api.serializers.user_serializer import *
from rest_framework.parsers import JSONParser 
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


