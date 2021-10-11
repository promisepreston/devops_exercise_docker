# /usr/bin/python3

import boto3

ec2 = boto3.resource('ec2')
instance = ec2.Instance('id')

response = instance.stop(
    Force=True
)
