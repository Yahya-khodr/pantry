
from rest_framework import serializers
from ..models import *


class CategoryModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = CategoryModel
        fields = '__all__'


class ProductModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductModel
        fields = ('id', 'barcode', 'product_name',
                  'product_quantity', 'product_image', 'category_id')


class ItemModelSerializer(serializers.ModelSerializer):
    product = ProductModelSerializer(many=False)

    class Meta:
        model = ItemModel
        fields = ('id', 'user_id', 'product',
                  'expiry_date', 'purchased_date')
