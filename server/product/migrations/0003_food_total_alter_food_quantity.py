# Generated by Django 4.0.3 on 2022-03-31 08:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('product', '0002_alter_productmodel_category_food'),
    ]

    operations = [
        migrations.AddField(
            model_name='food',
            name='total',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='food',
            name='quantity',
            field=models.TextField(default=0),
        ),
    ]
