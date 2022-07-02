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
    monthlyPriceResponse = [None] * 15
    timesUpdated = 0
    exchangeRatesTimeBlock = 0
    cryptoArticlesTimeBlock = 0
    monthlyPriceTimeBlock = 0
    firstTime = True


    def updateExchangeRates():
        if db.exchangeRatesTimeBlock <= time.time() - 3599:
            db.exchangeRatesResponse = requests.get("https://rest.coinapi.io/v1/exchangerate/USD?apikey=2538BC37-2458-49AC-82A8-772B98788B29&invert=true")
            db.exchangeRatesTimeBlock = time.time()
            db.updatePreviousRates()
            db.timesUpdated += 1

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
        if db.cryptoArticlesTimeBlock <= time.time() - 1799:
            db.cryptoArticlesResponse = requests.get("https://newsapi.org/v2/top-headlines?q=crypto&apiKey=06871c6b394f4c9198bfc4629a14b9ff")
            db.cryptoArticlesTimeBlock = time.time()

    def updateMonthlyPriceData():
        if db.monthlyPriceTimeBlock <= time.time() - 86399:
            db.monthlyPriceTimeBlock = time.time()

            """
                0: Bitcoin
                1: Dogecoin
                2: Ethereum
                3: Litecoin
                4: Cardano
                5: Tether
                6: Solana
                7: Binance
                8: USDCoin
                9: Algorand
                10: Polkadot
                11: BitcoinCash
                12: Monero
                13: Uniswap
                14: ShibaInu
            """

            time.sleep(10)

            #BTC
            db.monthlyPriceResponse[0] = requests.get("https://rest.coinapi.io/v1/exchangerate/BTC/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00")
            #DOGE
            db.monthlyPriceResponse[1] = requests.get("https://rest.coinapi.io/v1/exchangerate/DOGE/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00")
            #ETH
            db.monthlyPriceResponse[2] = requests.get("https://rest.coinapi.io/v1/exchangerate/ETH/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00")
            
            time.sleep(10)

            #LTC
            db.monthlyPriceResponse[3] = requests.get("https://rest.coinapi.io/v1/exchangerate/LTC/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00")
            #ADA
            db.monthlyPriceResponse[4] = requests.get("https://rest.coinapi.io/v1/exchangerate/ADA/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00")
            #USDT
            db.monthlyPriceResponse[5] = requests.get("https://rest.coinapi.io/v1/exchangerate/USDT/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00")
            
            time.sleep(10)

            #SOL
            db.monthlyPriceResponse[6] = requests.get("https://rest.coinapi.io/v1/exchangerate/SOL/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00")
            #BNB
            db.monthlyPriceResponse[7] = requests.get("https://rest.coinapi.io/v1/exchangerate/BNB/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00")
            #USDC
            db.monthlyPriceResponse[8] = requests.get("https://rest.coinapi.io/v1/exchangerate/USDC/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00")  
            
            time.sleep(10)

            #ALGO
            db.monthlyPriceResponse[9] = requests.get("https://rest.coinapi.io/v1/exchangerate/ALGO/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00")
            #DOT
            db.monthlyPriceResponse[10] = requests.get("https://rest.coinapi.io/v1/exchangerate/DOT/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00")
            #BCH
            db.monthlyPriceResponse[11] = requests.get("https://rest.coinapi.io/v1/exchangerate/BCH/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00") 
            
            time.sleep(10)

            #XMR
            db.monthlyPriceResponse[12] = requests.get("https://rest.coinapi.io/v1/exchangerate/XMR/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00")
            #UNI
            db.monthlyPriceResponse[13] = requests.get("https://rest.coinapi.io/v1/exchangerate/UNI/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00")
            #SHIB
            db.monthlyPriceResponse[14] = requests.get("https://rest.coinapi.io/v1/exchangerate/SHIB/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS&time_start=2022-05-23T00:00:00&time_end=2022-06-23T00:00:00") 
