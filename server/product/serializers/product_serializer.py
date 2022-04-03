

from unicodedata import category
from rest_framework import serializers
from ..models import *


class CategoryModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = CategoryModel
        fields = ('id', 'cat_name')


class ProductModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductModel
        fields = ('barcode', 'product_name',
                  'product_quantity', 'product_image', 'category')


class ItemModelSerializer(serializers.ModelSerializer):
    product = ProductModelSerializer(many=False)

    class Meta:
        model = ItemModel
        fields = ('user_id', 'product',
                  'expiry_date', 'purchased_date')


class FoodSerializer(serializers.ModelSerializer):

    class Meta:
        model = Food
        fields = '__all__'
