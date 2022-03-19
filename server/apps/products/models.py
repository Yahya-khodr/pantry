


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
    product_name = models.ImageField(null= True, blank = True)
    category = models.ForeignKey(CategoryModel, null=True, blank=True, on_delete=models.CASCADE)

    def __str__(self):
        return self.product_name
    


    