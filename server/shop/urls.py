
from django.urls import path
from . import views

urlpatterns = [
    path('items/', views.getShopItems),
    path('create_item/', views.createShopItem),
    path('update_item/<str:pk>/', views.updateShopItem),
    path('delete_item/<str:pk>/', views.deleteShopItem),
    path('items/<str:pk>/', views.getShopItem),
]