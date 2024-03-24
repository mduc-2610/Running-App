import random
from datetime import timedelta
from faker import Faker
from django.contrib.auth.hashers import make_password

from rest_framework.authtoken.models import Token

from account.models import User, \
                        Performance, \
                        Privacy, \
                        Profile, \
                        Activity

from activity.models import ActivityRecord, \
                            Club, \
                            Group, \
                            UserGroup, \
                            Event, \
                            UserParticipationClub, \
                            UserParticipationEvent

from product.models import Brand, \
                            Category, \
                            Product, \
                            ProductImage, \
                            UserProduct


def generate_phone_number():
    area_code = random.choice(['20', '21', '22', '23', '24', '25', '26', '27', '28', '29',
                               '30', '31', '32', '33', '34', '35', '36', '37', '38', '39',
                               '50', '51', '52', '53', '54', '55', '56', '57', '58', '59',
                               '70', '76', '77', '78', '79', '81', '82', '83', '84', '85',
                               '86', '88', '89', '91', '92', '93', '94', '96', '97', '98'])
    
    subscriber_number = ''.join(random.choices('0123456789', k=7))
    
    phone_number = f"0{area_code}{subscriber_number}"
    
    return phone_number
  
fake = Faker()
def run():
    model_list = [
        User, Performance, Privacy, Profile, Activity,
        ActivityRecord, Club, Group, UserGroup, 
        Event, UserParticipationClub, UserParticipationEvent,
        Brand, Category, Product, ProductImage, UserProduct, 
        Token
    ]

    for model in model_list:
        model.objects.all().delete()

    MAX_NUMBER_USERS = 30
    MAX_ACTIVITY_RECORDS = 100
    MAX_NUMBER_EVENTS = 30
    MAX_NUMBER_CLUBS = 50
    MAX_NUMBER_EVENT_GROUPS = 35
    MAX_NUMBER_USER_EVENT_GROUPS = 30
    MAX_NUMBER_USER_PARTICIPATION_CLUBS = 30
    MAX_NUMBER_USER_PARTICIPATION_EVENTS = 20
    MAX_NUMBER_USER_PRODUCTS = 50
    MAX_NUMBER_PRODUCT_IMAGES = 30
    # MAX_NUMBER_CATEGORIES = 20
    # MAX_NUMBER_BRANDS = 20
    # MAX_NUMBER_PRODUCTS = 50

    User.objects.create_superuser(username="duc", password="Duckkucd.123", email="duc@gmail.com")
    print("________________________________________________________________")
    print("USER:")
    user_list = []
    user_activity_list = []
    for _ in range(MAX_NUMBER_USERS):
        data = {
            "email": "".join([fake.email().split("@")[0] for x in range(2)]) + "@gmail.com",
            "username": "".join([fake.email().split("@")[0] for x in range(2)]),
            "phone_number": generate_phone_number(),
            "password": make_password("Duckkucd.123")
        }
        user = User.objects.create(**data)
        user_activity = Activity.objects.create(user=user)
        user_list.append(user)
        user_activity_list.append(user_activity)
        print(f"\tSuccesfully created User: {user}")
    
    print("________________________________________________________________")
    print("PROFILE:")
    profile_list = []
    for i in range(MAX_NUMBER_USERS):
        data = {
            "user": user_list[i],
            "avatar": "",
            "country": fake.country(),
            "city": fake.city(),
            "gender": random.choice(["MALE", "FEMALE"]),
            "date_of_birth": fake.date_time_between(start_date='-50y', end_date='-18y'),
            "height": random.randint(150, 200),
            "weight": random.randint(50, 100),
            "shirt_size": random.choice(['XS', 'S', 'M', 'L', 'XL', 'XXL']),
            "trouser_size": random.choice(['XS', 'S', 'M', 'L', 'XL', 'XXL']),
            "shoe_size": random.randint(36, 46),
        }
        profile = Profile.objects.create(**data)
        profile_list.append(profile)
        print(f"\tSuccesfully created Profile: {profile}")
    
    print("________________________________________________________________")
    print("PRIVACY")
    privacy_list = []
    for i in range(MAX_NUMBER_USERS):
        data = {
            "user": user_list[i],
            "follow_privacy": random.choice(["APPROVAL", "NO_APPROVAL"]),
            "activity_privacy": random.choice(["EVERYONE", "FOLLOWER", "ONLY YOU"]),
        }
        privacy = Privacy.objects.create(**data)
        privacy_list.append(privacy)
        print(f"\tSuccesfully created Privacy: {privacy}")
        
    print("________________________________________________________________")
    print("PERFORMANCE")
    performance_list = []
    for i in range(MAX_NUMBER_USERS):
        data = {
            "user": user_list[i],
        }
        performance = Performance.objects.create(**data)
        performance_list.append(performance)
        print(f"\tSuccesfully created Performance: {performance}")
    
    print("________________________________________________________________")
    print("ACTIVITY RECORD:")
    activity_record_list = []
    for i in range(MAX_ACTIVITY_RECORDS):
        data = {
            "distance": random.uniform(0, 10),
            "duration": timedelta(hours=random.randint(0, 3), minutes=random.randint(0, 59), seconds=random.randint(0, 59)),
            "completed_at": fake.date_time_this_year(),
            "sport_type": random.choice(["RUNNING", "CYCLING", "SWIMMING", "JOGGING"]),
            "description": fake.text(max_nb_chars=250),
            "user": random.choice(user_list),
        }
        activity_record = ActivityRecord.objects.create(**data)
        activity_record_list.append(activity_record)
        print(f"\tSuccesfully created Activity Record: {activity_record}")

    print("________________________________________________________________")
    print("CLUB:")
    club_list = []
    for i in range(MAX_NUMBER_CLUBS):
        data = {
            "name": fake.company(),
            "avatar": "",
            "cover_photo": "",
            "sport_type": random.choice(["RUNNING", "CYCLING", "SWIMMING"]),
            "description": fake.text(max_nb_chars=250),
            "privacy": random.choice(["Public", "Private"]),
            "organization": random.choice(["SPORT_CLUB", "BUSINESS", "SCHOOL"]),
        }
        club = Club.objects.create(**data)
        club_list.append(club)
        print(f"\tSuccesfully created Club: {club}")
    
    print("________________________________________________________________")
    print("EVENT:")
    event_list = []
    started_time = fake.date_time_this_year()
    ended_time = fake.date_time_this_year()
    while ended_time <= started_time:
        ended_time = fake.date_time_this_year()
    for i in range(MAX_NUMBER_EVENTS):
        min_avg_pace = timedelta(hours=random.randint(0, 3), minutes=random.randint(0, 59))
        max_avg_pace = timedelta(hours=random.randint(0, 3), minutes=random.randint(0, 59))
        if max_avg_pace <= min_avg_pace:
            min_avg_pace, max_avg_pace = max_avg_pace, min_avg_pace
            
        data = {
            "name": fake.company(),
            "started_at": started_time,
            "ended_at": ended_time,
            "regulations": {
                "min_distance": 1,
                "max_distance": random.randint(80, 100),
                "min_avg_pace": str(min_avg_pace),
                "max_avg_pace": str(max_avg_pace),
            },
            "description": fake.text(max_nb_chars=250),
            "contact_information": fake.text(max_nb_chars=100),
            "banner": "",
            "sport_type": random.choice(["RUNNING", "CYCLING", "SWIMMING"]),
            "privacy": random.choice(["PUBLIC", "PRIVATE"]),
            "competition": random.choice(["INDIVIDUAL", "GROUP"])
        }
        event = Event.objects.create(**data)
        event_list.append(event)
        print(f"\tSuccesfully created Event: {event}")

    print("________________________________________________________________")
    print("EVENT GROUP:")
    event_group_list = []
    for i in range(MAX_NUMBER_EVENT_GROUPS):
        data = {
            "name": fake.company(),
            "description": fake.text(max_nb_chars=250),
            "avatar": "",
            "event": random.choice(event_list),
        }
        event_group = Group.objects.create(**data)
        event_group_list.append(event_group)
        print(f"\tSuccesfully created Event Group: {event_group}")
    
    print("________________________________________________________________")
    print("USER EVENT GROUP:")
    user_event_group_list = []
    for i in range(MAX_NUMBER_USER_EVENT_GROUPS):
        data = {
            "user": user_list[i],
            "group": random.choice(event_group_list),
            "participated_at": fake.date_time_this_year(),
            "is_admin": random.choice([True, False])
        }
        user_event_group, _ = UserGroup.objects.get_or_create(**data)
        user_event_group_list.append(user_event_group)
        print(f"\tSuccesfully created User Event Group: {user_event_group}")
    
    print("________________________________________________________________")
    print("USER PARTICIPATION CLUB:")
    user_participation_club_list = []
    for club in club_list:
        user_tmp = user_activity_list.copy()
        for i in range(random.randint(0, max(MAX_NUMBER_USER_PARTICIPATION_CLUBS, MAX_NUMBER_USERS))):
            random_user = user_tmp.pop(random.randint(0, len(user_tmp) - 1))
            data = {
                "user": random_user,
                "club": club,
                "is_admin": random.choice([True, False]),
                "participated_at": fake.date_time_this_year(),
            }
            user_participation_club, _ = UserParticipationClub.objects.get_or_create(**data)
            user_participation_club_list.append(user_participation_club)
            print(f"\tSuccesfully created User Participation Club: {user_participation_club}")
    
    print("________________________________________________________________")
    print("USER PARTICIPATION EVENT:")
    user_participation_event_list = []
    for event in event_list:
        user_tmp = user_activity_list.copy()
        for i in range(random.randint(0, max(MAX_NUMBER_USER_PARTICIPATION_EVENTS, MAX_NUMBER_USERS))):
            random_user = user_tmp.pop(random.randint(0, len(user_tmp) - 1))
            data = {
                "user": random_user,
                "participated_at": fake.date_time_this_year(),
                "event": event,
                "is_superadmin": True if i == 0 else False
            }
            user_participation_event = UserParticipationEvent.objects.create(**data)
            user_participation_event_list.append(user_participation_event)
            print(f"\tSuccesfully created User Participation Event: {user_participation_event}")

    
    print("________________________________________________________________")
    print("CATEGORY:")
    categories = [
        "Shoes", "Apparel", "Accessories", "Watches", "Hydration Packs", "Socks", "Hats", "Gloves", "Sunglasses",
        "Swimsuits", "Goggles", "Caps", "Training Equipment", "Fins", "Paddles", "Snorkels", "Kickboards", "Buoy",
        "Bikes", "Apparel", "Accessories", "Helmets", "Shoes", "Gloves", "Sunglasses", "Jerseys", "Shorts"
    ]
    category_list = []
    for category_ in categories:
        random_event = random.choice(event_list)
        data = {
            "name": category_,
        }
        category = Category.objects.create(**data)
        category_list.append(category)
        print(f"\tSuccesfully created Category: {category}")
    
    print("________________________________________________________________")
    print("BRAND:")
    brands = ["Nike", "Adidas", "New Balance", "Asics", "Brooks", "Saucony", "Under Armour", "Puma", "Reebok",
                    "Speedo", "TYR", "Arena", "FINIS", "Dolfin", "Funky Trunks", "MP Michael Phelps", "Zoggs", "Aqua Sphere"
                    "Giant", "Trek", "Specialized", "Cannondale", "Scott", "Bianchi", "Cervélo", "Felt", "Colnago"]
    brand_list = []
    for brand_  in brands:
        random_event = random.choice(event_list)
        data = {
            "name": brand_,
            "logo": ""
        }
        brand = Brand.objects.create(**data)
        brand_list.append(brand)
        print(f"\tSuccesfully created Brand: {brand}")
        
    print("________________________________________________________________")
    print("PRODUCT:")
    products = [
        "RunSwimCyclone Shoes", "AquaticStride Apparel", "TriathlonGear Accessories", 
        "AeroStream Watches", "HydroFlow Hydration Packs", "StrideWave Socks",
        "CycleRide Hats", "RunAqua Gloves", "TriathlonTrek Sunglasses",
        "AquaGlide Swimsuits", "CycleMotion Goggles", "RunSwimCap Caps",
        "TriathlonTraining Equipment", "AquaForce Fins", "CyclePaddle Paddles", 
        "RunRipple Snorkels", "SwimStride Kickboards", "CycleBoost Buoy",
        "TriBike Bikes", "AquaThrust Apparel", "CycleGlide Accessories",
        "TriHelmet Helmets", "RunCycle Shoes", "AquaGrip Gloves",
        "TriathlonShade Sunglasses", "CycleJersey Jerseys", "RunShorts Shorts"
    ]
    product_list = []
    for product_ in products:
        random_event = random.choice(event_list)
        data = {
            "name": product_,
            "brand": random.choice(brand_list),
            "category": random.choice(category_list),
            "price": random.randint(10000, 50000),
            "description": fake.text(max_nb_chars=250),
        }
        product = Product.objects.create(**data)
        product_list.append(product)
        print(f"\tSuccesfully created Product: {product}")
    
    print("________________________________________________________________")
    print("PRODUCT IMAGE:")
    product_image_list = []
    for product in product_list:
        for i in range(random.randint(0, MAX_NUMBER_PRODUCT_IMAGES)):
            data = {
                "product": product,  
                "image": "",
            }
            product_image = ProductImage.objects.create(**data)
            product_image_list.append(product_image)
            print(f"\tSuccesfully created Product Image: {product_image}")
    
    print("________________________________________________________________")
    print("USER:")
    user_product_list = []
    for i in range(MAX_NUMBER_USER_PRODUCTS):
        data = {
            "user": random.choice(user_activity_list),
            "product": random.choice(product_list),
        }
        user_product = UserProduct.objects.get_or_create(**data)
        user_product_list.append(user_product)
        print(f"\tSuccesfully created User Product: {user_product}")
