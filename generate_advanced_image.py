#!/usr/bin/env python3
"""
Codex 자동화: 고급 이미지 생성
여러 종류의 이미지를 동시에 생성하는 예제
"""

from PIL import Image, ImageDraw, ImageFont, ImageFilter
import os
from datetime import datetime

def create_gradient_image(width=1280, height=720, name="gradient"):
    """그라디언트 이미지 생성"""
    img = Image.new('RGB', (width, height))
    pixels = img.load()

    for y in range(height):
        for x in range(width):
            r = int(255 * (x / width))
            g = int(255 * (y / height))
            b = 200
            pixels[x, y] = (r, g, b)

    output = f'/tmp/codex_{name}.png'
    img.save(output)
    return output

def create_geometric_image(width=800, height=600, name="geometric"):
    """기하학적 패턴 이미지"""
    img = Image.new('RGB', (width, height), color=(30, 30, 50))
    draw = ImageDraw.Draw(img)

    # 원 그리기
    for i in range(10):
        x = (width // 10) * (i + 1)
        y = height // 2
        radius = 40 + i * 10
        color = (100 + i * 15, 150, 200 - i * 10)
        draw.ellipse([x - radius, y - radius, x + radius, y + radius], fill=color, outline=(255, 255, 255))

    output = f'/tmp/codex_{name}.png'
    img.save(output)
    return output

def create_text_image(text="Codex Generated", width=1000, height=400, name="text"):
    """텍스트 이미지"""
    img = Image.new('RGB', (width, height), color=(50, 50, 100))
    draw = ImageDraw.Draw(img)

    # 텍스트 위치
    draw.text((50, 150), text, fill=(255, 200, 100))
    draw.text((50, 250), f"Created: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}", fill=(200, 200, 200))

    output = f'/tmp/codex_{name}.png'
    img.save(output)
    return output

if __name__ == "__main__":
    print("🎨 고급 이미지 생성 시작...")

    images = [
        create_gradient_image(name="gradient"),
        create_geometric_image(name="geometric"),
        create_text_image(name="text_overlay")
    ]

    print(f"\n✅ {len(images)}개 이미지 생성 완료!")
    for img in images:
        size = os.path.getsize(img) / 1024
        print(f"   📍 {img} ({size:.1f} KB)")

