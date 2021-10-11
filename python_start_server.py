# /usr/bin/python3.8

import boto3

ec2 = boto3.resource('ec2')
instance = ec2.Instance('id')

response = instance.start(
    AdditionalInfo='string'
)
