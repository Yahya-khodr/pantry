

from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from shop.models import ShopItem
from shop.serializer import ShopItemSerializer
from users.models import UserModel

# Create your views here.





@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getShopItems(request):
    user = UserModel.objects.get(id=request.user.id)
    items = ShopItem.objects.filter(user=user)
    serializer = ShopItemSerializer(items, many=True)
    return Response(serializer.data)

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getShopItem(request, pk):
    item = ShopItem.objects.get(id=pk)
    serializer = ShopItemSerializer(item, many=False)
    return Response(serializer.data)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def createShopItem(request):
    try:
        data = request.data
        user = UserModel.objects.get(id=request.user.id)
        # file = data["file"]
        # name = data["image_name"]
        # image_file = ContentFile(base64.b64decode(file), name)
        form_data = {
            **data, "user" : user.id, #"image":image_file
        }
        data = form_data
        seriializer = ShopItemSerializer(data=data)
        if seriializer.is_valid():
            seriializer.save()
            return Response(seriializer.data)
        return Response(seriializer.errors)
    except Exception as ex:
        raise ex



@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def updateShopItem(request, pk):
    item = ShopItem.objects.get(id=pk)
    serializer = ShopItemSerializer(item, data=request.data)
    if serializer.is_valid():
        serializer.save()

    return Response(serializer.data)

@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
def deleteShopItem(request, pk):
    item = ShopItem.objects.get(id=pk)
    item.delete()
    return Response('Item was deleted!')


