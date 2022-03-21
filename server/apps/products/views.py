


from rest_framework.decorators import api_view
from rest_framework.response import Response
from apps.products.models import *
from apps.products.serializers import *



@api_view(['GET'])
def get_product(request, barcode):
    product = ProductModel.objects.get(code = barcode)
    serialized = ProductModelSerializer(product, many=False)
    return Response(serialized.data)

@api_view(['POST'])
def add_product(request):
    serialized = ProductModelSerializer(data=request.data)
    if serialized.is_valid():
        serialized.save()
        return Response(serialized.data)    

    
@api_view(['GET'])
def get_product_by_category(request,category):
    product = ProductModel.objects.filter(
        category__cat_name = category
    )
    serialized = ProductModelSerializer(product, many= True)
    return Response(serialized.data)



