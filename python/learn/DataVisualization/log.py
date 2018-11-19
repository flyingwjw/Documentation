import pandas as pd

headers = ["datatime", "source", "type", "log"]

df = pd.read_csv('access_logs.csv', quotechar="'", names=headers)
print(df)

print(df.to_string())