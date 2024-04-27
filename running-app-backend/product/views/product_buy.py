from rest_framework import views, response, status

from django.contrib.auth.hashers import check_password
from account.models import User
from product.models import Product

class ProductBuyView(views.APIView):
    def post(self, request):
        user = request.user
        # user_id = request.data.get('user_id')
        product_id = request.data.get('product_id')
        password = request.data.get('password')
        
        # user = User.objects.get(id=user_id)
        if not check_password(password, user.password):
            return response.Response(
                {"message": "Incorrect password"}, status=status.HTTP_400_BAD_REQUEST)
        
        product = Product.objects.get(id=product_id)
        if user.performance.total_points >= product.price:
            user.performance.total_points -= product.price
            user.performance.save()
            user.activity.products.add(product)
            return response.Response(
                {"message": "Product bought successfully"}, status=status.HTTP_200_OK)
        else:
            return response.Response(
                {"message": "Not enough points"}, status=status.HTTP_400_BAD_REQUEST)