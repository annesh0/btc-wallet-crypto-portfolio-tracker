from urllib import response
from flask import Flask
import json
import requests
import time
from datetime import datetime
from flask import request
from sqlalchemy import false
class db:
    exchangeRatesResponse = None
    previousExchangeRatesResponses = []
    cryptoArticlesResponse = None
    weeklyPriceResponse = [None] * 15
    monthlyPriceResponse = [None] * 15
    yearlyPriceResponse = [None] * 15
    timesUpdated = 0
    exchangeRatesTimeBlock = 0
    cryptoArticlesTimeBlock = 0
    graphTimeBlock = 0
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

    def updateGraphData():
        if db.graphTimeBlock <= time.time() - 86399:
            db.graphTimeBlock = time.time()

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
            today = datetime.utcfromtimestamp(int(db.graphTimeBlock)).isoformat() + ""
            oneWeekAgo = datetime.utcfromtimestamp(int(db.graphTimeBlock- 604800)).isoformat() + ""
            oneMonthAgo = datetime.utcfromtimestamp(int(db.graphTimeBlock - 2678400)).isoformat() + ""
            oneYearAgo = datetime.utcfromtimestamp(int(db.graphTimeBlock - 31536000)).isoformat() + ""
            time.sleep(10)

            #BTC
            db.weeklyPriceResponse[0] = requests.get("https://rest.coinapi.io/v1/exchangerate/BTC/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[0] = requests.get("https://rest.coinapi.io/v1/exchangerate/BTC/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today})
            db.yearlyPriceResponse[0] = requests.get("https://rest.coinapi.io/v1/exchangerate/BTC/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})
            #DOGE
            db.weeklyPriceResponse[1] = requests.get("https://rest.coinapi.io/v1/exchangerate/DOGE/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[1] = requests.get("https://rest.coinapi.io/v1/exchangerate/DOGE/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today})
            db.yearlyPriceResponse[1] = requests.get("https://rest.coinapi.io/v1/exchangerate/DOGE/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})
            #ETH
            db.weeklyPriceResponse[2] = requests.get("https://rest.coinapi.io/v1/exchangerate/ETH/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[2] = requests.get("https://rest.coinapi.io/v1/exchangerate/ETH/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today})
            db.yearlyPriceResponse[2] = requests.get("https://rest.coinapi.io/v1/exchangerate/ETH/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})

            time.sleep(10)

            #LTC
            db.weeklyPriceResponse[3] = requests.get("https://rest.coinapi.io/v1/exchangerate/LTC/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[3] = requests.get("https://rest.coinapi.io/v1/exchangerate/LTC/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today})
            db.yearlyPriceResponse[3] = requests.get("https://rest.coinapi.io/v1/exchangerate/LTC/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})
            #ADA
            db.weeklyPriceResponse[4] = requests.get("https://rest.coinapi.io/v1/exchangerate/ADA/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[4] = requests.get("https://rest.coinapi.io/v1/exchangerate/ADA/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today})
            db.yearlyPriceResponse[4] = requests.get("https://rest.coinapi.io/v1/exchangerate/ADA/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})
            #USDT
            db.weeklyPriceResponse[5] = requests.get("https://rest.coinapi.io/v1/exchangerate/USDT/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[5] = requests.get("https://rest.coinapi.io/v1/exchangerate/USDT/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today})
            db.yearlyPriceResponse[5] = requests.get("https://rest.coinapi.io/v1/exchangerate/USDT/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})

            time.sleep(10)

            #SOL
            db.weeklyPriceResponse[6] = requests.get("https://rest.coinapi.io/v1/exchangerate/SOL/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[6] = requests.get("https://rest.coinapi.io/v1/exchangerate/SOL/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today})
            db.yearlyPriceResponse[6] = requests.get("https://rest.coinapi.io/v1/exchangerate/SOL/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})
            #BNB
            db.weeklyPriceResponse[7] = requests.get("https://rest.coinapi.io/v1/exchangerate/BNB/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[7] = requests.get("https://rest.coinapi.io/v1/exchangerate/BNB/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today})
            db.yearlyPriceResponse[7] = requests.get("https://rest.coinapi.io/v1/exchangerate/BNB/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})
            #USDC
            db.weeklyPriceResponse[8] = requests.get("https://rest.coinapi.io/v1/exchangerate/USDC/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[8] = requests.get("https://rest.coinapi.io/v1/exchangerate/USDC/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today})  
            db.yearlyPriceResponse[8] = requests.get("https://rest.coinapi.io/v1/exchangerate/USDC/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})

            time.sleep(10)

            #ALGO
            db.weeklyPriceResponse[9] = requests.get("https://rest.coinapi.io/v1/exchangerate/ALGO/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[9] = requests.get("https://rest.coinapi.io/v1/exchangerate/ALGO/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today})
            db.yearlyPriceResponse[9] = requests.get("https://rest.coinapi.io/v1/exchangerate/ALGO/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})
            #DOT
            db.weeklyPriceResponse[10] = requests.get("https://rest.coinapi.io/v1/exchangerate/DOT/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[10] = requests.get("https://rest.coinapi.io/v1/exchangerate/DOT/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today})
            db.yearlyPriceResponse[10] = requests.get("https://rest.coinapi.io/v1/exchangerate/DOT/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})
            #BCH
            db.weeklyPriceResponse[11] = requests.get("https://rest.coinapi.io/v1/exchangerate/BCH/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[11] = requests.get("https://rest.coinapi.io/v1/exchangerate/BCH/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today}) 
            db.yearlyPriceResponse[11] = requests.get("https://rest.coinapi.io/v1/exchangerate/BCH/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})

            time.sleep(10)

            #XMR
            db.weeklyPriceResponse[12] = requests.get("https://rest.coinapi.io/v1/exchangerate/XMR/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[12] = requests.get("https://rest.coinapi.io/v1/exchangerate/XMR/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today})
            db.yearlyPriceResponse[12] = requests.get("https://rest.coinapi.io/v1/exchangerate/XMR/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})
            #UNI
            db.weeklyPriceResponse[13] = requests.get("https://rest.coinapi.io/v1/exchangerate/UNI/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[13] = requests.get("https://rest.coinapi.io/v1/exchangerate/UNI/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today})
            db.yearlyPriceResponse[13] = requests.get("https://rest.coinapi.io/v1/exchangerate/UNI/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})
            #SHIB
            db.weeklyPriceResponse[14] = requests.get("https://rest.coinapi.io/v1/exchangerate/SHIB/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=2HRS", params= {"time_start" : oneWeekAgo, "time_end" : today})
            db.monthlyPriceResponse[14] = requests.get("https://rest.coinapi.io/v1/exchangerate/SHIB/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=12HRS", params= {"time_start" : oneMonthAgo, "time_end" : today}) 
            db.yearlyPriceResponse[14] = requests.get("https://rest.coinapi.io/v1/exchangerate/SHIB/USD/history?apikey=2538BC37-2458-49AC-82A8-772B98788B29&period_id=5DAY", params= {"time_start" : oneYearAgo, "time_end" : today})