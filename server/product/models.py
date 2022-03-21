

from django.db import models
from api.models import UserModel
# Create your models here.

class CategoryModel(models.Model):
    cat_name = models.CharField(max_length=255)

    def __str__(self):
        return self.cat_name

class ProductModel(models.Model):

    barcode = models.CharField(max_length=255, unique=True)
    product_name = models.TextField()
    product_quantity = models.TextField()
    product_image = models.ImageField(null= True, blank = True)
    category = models.ForeignKey(CategoryModel, models.CASCADE)

    def __str__(self):
        return self.product_name



class ItemModel(models.Model):
    user = models.ForeignKey(UserModel,models.CASCADE)
    product = models.ForeignKey(ProductModel, models.CASCADE)
    company_name = models.CharField(max_length=255)
    expiry_date = models.DateField()
    purchased_date = models.DateField()
    created_date = models.DateField(auto_now_add=True)
    update_date = models.DateField(auto_now=True)