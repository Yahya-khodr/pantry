
from rest_framework import serializers

from ..models import *

class CategoryModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = CategoryModel
        fields = '__all__'


class ProductModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductModel
        fields = '__all__'



class ItemModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = ItemModel
        fields= '__all__'