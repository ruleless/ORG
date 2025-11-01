"""一个简单的单头自注意力模块的实现"""

import math
import torch
from torch import nn, Tensor
import torch.nn.functional as F


class SelfAttention(nn.Module):
    """自注意力机制"""

    def __init__(self, in_dim=768, out_dim=768):
        super().__init__()

        self.w_q = nn.Linear(in_dim, out_dim, bias=False)
        self.w_k = nn.Linear(in_dim, out_dim, bias=False)
        self.w_v = nn.Linear(in_dim, out_dim, bias=False)

    def forward(self, x: Tensor) -> Tensor:
        """前向传播"""
        # shape of x: (batch_size, seq_len, in_dim)
        query: Tensor = self.w_q(x)  # (batch_size, seq_len, out_dim)
        key: Tensor = self.w_k(x)
        value: Tensor = self.w_v(x)

        # PyTorch提供了 `scaled_dot_product_attention` 来高效地计算缩放点积注意力
        # return F.scaled_dot_product_attention(query, key, value, is_causal=False)
        attn_score = query @ key.transpose(-2, -1)
        attn_score /= math.sqrt(query.size(-1))
        attn_weight = torch.softmax(attn_score, -1)  # (batch_size, seq_len, seq_len)
        return attn_weight @ value


if __name__ == "__main__":
    model = SelfAttention(in_dim=8, out_dim=8)
    x = torch.rand((10, 8))
    y = model(x)
    print(x, "\n->\n", y)
