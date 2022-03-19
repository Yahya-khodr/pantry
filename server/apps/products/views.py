
import code
from rest_framework.decorators import api_view
from rest_framework.response import Response
from apps.products.models import *
from apps.products.serializers import *
# Create your views here.


@api_view(['GET'])
def get_product(request, barcode):
    product = ProductModel.objects.get(code = barcode)
    serialized = ProductModelSerializer(product, many=False)
    return Response(serialized.data)