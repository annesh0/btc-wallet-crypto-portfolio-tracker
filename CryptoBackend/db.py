from urllib import response
from flask import Flask
import json
import requests
import time
from flask import request
from sqlalchemy import false
class db:
    exchangeRatesResponse = None
    previousExchangeRatesResponses = []
    cryptoArticlesResponse = None
    exchangeRatesTimeBlock = 0
    cryptoArticlesTimeBlock = 0
    firstTime = True

    def updateExchangeRates():
        if db.exchangeRatesTimeBlock <= time.time() - 3600:
            db.exchangeRatesResponse = requests.get("https://rest.coinapi.io/v1/exchangerate/USD?apikey=2538BC37-2458-49AC-82A8-772B98788B29&invert=true")
            db.exchangeRatesTimeBlock = time.time()
            db.updatePreviousRates()

    def updatePreviousRates():
        if db.firstTime:
            for i in range(25):
                db.previousExchangeRatesResponses.append(db.exchangeRatesResponse)
            db.firstTime = False
        else:
            for i in range(24):
                db.previousExchangeRatesResponses[i] = db.previousExchangeRatesResponses[i+1]
            db.previousExchangeRatesResponses[24] = db.exchangeRatesResponse

    def updateNewsArticles():
        if db.cryptoArticlesTimeBlock <= time.time() - 1800:
            db.cryptoArticlesResponse = requests.get("https://newsapi.org/v2/top-headlines?q=crypto&apiKey=06871c6b394f4c9198bfc4629a14b9ff")
            db.cryptoArticlesTimeBlock = time.time()