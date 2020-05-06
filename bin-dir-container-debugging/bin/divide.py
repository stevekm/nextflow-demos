#!/usr/bin/env python
"""
Example Python program that divides two values
"""
import sys
args = sys.argv[1:]

numerator = float(args[0])
denominator = float(args[1])

# comment this out to fix divide by zero errors!
result = numerator / denominator

# # uncomment this out to fix divide by zero errors!
# try:
#     result = numerator / denominator
# except ZeroDivisionError:
#     result = "NA"

print("numerator: {}, denominator: {}, result: {}".format(numerator, denominator, result))
