import bottle
import pymongo

from pymongo import MongoClient
import pandas as pd

import json

from bottle import response, template
from bson.json_util import dumps



@bottle.get('/')
def home_page():



    client = MongoClient('localhost', 27017)

    db = client.wycenyAllianz


    collection = db.fundusze

    query = {'Data wyceny': {'$gt': '2017-01-01'}}

    pd.set_option('display.float_format', lambda x: '%.0f' %x)

    wyceny = pd.DataFrame(list(collection.find(query)))

    
    wyceny.drop(wyceny.columns[0], axis=1, inplace=True)
    wyceny.drop('_id', axis=1, inplace=True)
    dane = wyceny.to_json(orient='index')






    return template('view2', dane = dane)




bottle.debug(True)
bottle.run(host='localhost', port=8080)
