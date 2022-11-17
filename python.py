# async requests
import asyncio
import requests

url = "http://www.google.com"

async def main():
    loop = asyncio.get_event_loop()
    futures = [
        loop.run_in_executor(
            None, 
            requests.post, 
            url
        )
        for i in range(10)
    ]
    for response in await asyncio.gather(*futures):
        print(f'response: {response.status_code}')

loop = asyncio.get_event_loop()
loop.run_until_complete(main())
