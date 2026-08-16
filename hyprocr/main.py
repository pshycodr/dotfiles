from rapidocr import RapidOCR
import sys

if len(sys.argv) != 2:
    print("Usage: python main.py <image>")
    raise SystemExit(1)

engine = RapidOCR()

result = engine(sys.argv[1])

if not result.txts:
    raise SystemExit(0)

print("\n".join(result.txts))
