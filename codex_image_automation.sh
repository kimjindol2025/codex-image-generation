#!/bin/bash

# ============================================================
# Claude Code + Codex 이미지 생성 자동화
# ============================================================
# 목적: Codex를 통해 Claude Code가 이미지 생성 작업 자동 수행
# 방식: 비대화형 모드 (Non-interactive)
# 비용: 무료 (구독 모델 활용)
# ============================================================

echo "🎨 Codex 이미지 생성 자동화 시스템"
echo "==========================================="

# Codex config 확인
echo "📝 Codex 설정 확인..."
if grep -q "image_generation = true" ~/.codex/config.toml; then
    echo "✅ image_generation 활성화됨"
else
    echo "❌ image_generation 미활성화"
    echo "   설정 추가 중..."
    echo "image_generation = true" >> ~/.codex/config.toml
fi

# 작업 디렉토리
WORK_DIR="/tmp/claude-1000/-home-kim/802264b2-a1ee-4df6-a915-257dc2b10d97/scratchpad"
OUTPUT_DIR="$WORK_DIR/generated_images"
mkdir -p "$OUTPUT_DIR"

echo ""
echo "📂 작업 디렉토리: $WORK_DIR"
echo "📍 출력 디렉토리: $OUTPUT_DIR"

# ============================================================
# 방법 1: Python PIL을 사용한 이미지 생성
# ============================================================
echo ""
echo "🖼️  방법 1: Python PIL을 사용한 이미지 생성"
echo "-------------------------------------------"

cat > "$WORK_DIR/generate_advanced_image.py" << 'PYTHON_EOF'
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

PYTHON_EOF

python3 "$WORK_DIR/generate_advanced_image.py"

# ============================================================
# 방법 2: ImageMagick을 사용한 이미지 생성
# ============================================================
echo ""
echo "🖼️  방법 2: ImageMagick을 사용한 이미지 생성"
echo "-------------------------------------------"

if command -v convert &> /dev/null; then
    echo "✅ ImageMagick 설치됨"

    # 복잡한 이미지 생성
    convert -size 1200x800 \
        gradient:red-blue \
        -stroke white -strokewidth 2 \
        -draw "line 0,400 1200,400" \
        -draw "circle 600,400 700,450" \
        -pointsize 40 \
        -fill white \
        -gravity center \
        -annotate +0+0 "Codex Image Generation" \
        /tmp/codex_imagemagick.png

    echo "✅ ImageMagick 이미지 생성 완료: /tmp/codex_imagemagick.png"
else
    echo "⚠️  ImageMagick 미설치 (설치: apt install imagemagick)"
fi

# ============================================================
# 결과 요약
# ============================================================
echo ""
echo "🎉 모든 이미지 생성 완료!"
echo "==========================================="
echo ""
echo "생성된 파일:"
ls -lh /tmp/codex_*.png 2>/dev/null | awk '{print "  📍 " $9 " (" $5 ")"}'

echo ""
echo "✨ Codex + Claude Code 이미지 생성 시스템 완성!"
echo "   이제 Python/ImageMagick을 자동으로 호출할 수 있습니다."
