import pandas as pd
import torch

print(pd.__version__)
print(torch.__version__)

device = torch.device("cuda") if torch.cuda.is_available() else torch.device("cpu")
print(device)


