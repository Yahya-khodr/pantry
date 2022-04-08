from django.db import models

from users.models import UserModel

# Create your models here.



class ShopItem(models.Model):
    user = models.ForeignKey(UserModel, models.CASCADE)
    item_name = models.CharField(max_length=255)
    quantity = models.IntegerField(default=0)
    image = models.ImageField(null=True, blank=True)
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.body[0:50]

    class Meta:
        ordering = ['-updated']