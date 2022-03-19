


from statistics import mode
from tkinter import CASCADE
from django.conf import settings
from django.db import models

# Create your models here.


class CategoryModel(models.Model):
    cat_name = models.CharField(max_length=255)

    def __str__(self):
        return self.cat_name

class ProductModel(models.Model):
    code = models.CharField(max_length=100, unique=True)
    product_name = models.TextField()
    product_quantity = models.TextField()
    product_image = models.ImageField(null= True, blank = True)
    category = models.ForeignKey(CategoryModel, models.CASCADE)

    def __str__(self):
        return self.product_name
    


class ItemModel(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL,models.CASCADE)
    product = models.ForeignKey(ProductModel, models.CASCADE)
    company_name = models.CharField(max_length=255)
    expiry_date = models.DateField()
    purchased_date = models.DateField()
    created_date = models.DateField(auto_now_add=True)
    update_date = models.DateField(auto_now=True)