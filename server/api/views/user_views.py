
from django.core.files.base import ContentFile
import base64
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.status import HTTP_200_OK, HTTP_400_BAD_REQUEST, HTTP_404_NOT_FOUND
from rest_framework.authtoken.models import Token
from django.contrib.auth import authenticate
from api.serializers import user_serializer
from ..models import *
from django.utils.text import  slugify

@api_view(['POST'])
def login_view(request):
    data = request.data
    email = data['email']
    password = data['password']


    try:
        auth_user = authenticate(email=email, password = password)
    except:
        return Response({"error" : "Invalid Credentials"}, status=HTTP_400_BAD_REQUEST)

    if auth_user and auth_user.is_active:
        return Response({"token" : auth_user.token}, status=HTTP_200_OK)
    elif auth_user and not auth_user.is_active:
        return Response({"error": "Your account is suspended"}, status=HTTP_400_BAD_REQUEST)
    else:
        return Response({"error": "Invalid Credentials"}, status=HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def signup_view(request):
    data = request.data
    name = data['name']
    email = data['email']
    password = data['password']
    try:
        user = UserModel.objects.create_user(
            name=name, email=email, password=password)
        slug_str = "%s %s" % (user.name, user.id)
        slug = slugify(slug_str)
        user.slug = slug
        token, created = Token.objects.get_or_create(user=user)
        user.token = token.key
        user.save()
        ProfileModel.objects.create(user=user)
        
        return Response({"token": token.key}, status=HTTP_200_OK)
    except:
        return Response({"error": "User already exists"}, status=HTTP_400_BAD_REQUEST)



@api_view(['GET'])
@permission_classes([IsAuthenticated])
def profile_view(request):  # profile view
    user = UserModel.objects.get(id=request.user.id)
    profile = ProfileModel.objects.get(user=user)

    serialized_user = user_serializer.UserModelSerializer(user, many=False).data
    serialized_profile = user_serializer.ProfileModelSerializer(profile, many=False).data

    return Response({"user": serialized_user, "profile": serialized_profile}, status=HTTP_200_OK)



@api_view(['POST'])
@permission_classes([IsAuthenticated])
def update_user(request):  # edit profile view
    data = request.data
    name = data['name']
    email = data['email']

    try:
        user = UserModel.objects.get(id=request.user.id)
        if user.name != name:
            user.name = name

        if user.email != email:
            user.email = email

        user.save()
        return Response(status=HTTP_200_OK)
    except:
        return Response(status=HTTP_404_NOT_FOUND)



