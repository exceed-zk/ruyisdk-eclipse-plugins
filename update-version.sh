#!/bin/bash

# RuyiSDK Eclipse 插件版本更新脚本
# 用法: ./update-version.sh <新版本号>
# 例如: ./update-version.sh 0.0.5

set -e

if [ -z "$1" ]; then
    echo "错误: 请提供新版本号"
    echo "用法: $0 <版本号>"
    echo "例如: $0 0.0.5"
    exit 1
fi

NEW_VERSION=$1
QUALIFIER_VERSION="${NEW_VERSION}.qualifier"
SNAPSHOT_VERSION="${NEW_VERSION}-SNAPSHOT"

echo "========================================"
echo "更新版本号到: $NEW_VERSION"
echo "========================================"

# 1. 更新根 pom.xml
echo "📝 更新根 pom.xml..."
sed -i "0,/<version>.*<\/version>/s/<version>.*<\/version>/<version>${SNAPSHOT_VERSION}<\/version>/" pom.xml

# 2. 更新 feature.xml
echo "📝 更新 feature.xml..."
FEATURE_XML="features/org.ruyisdk.feature/feature.xml"
if [ -f "$FEATURE_XML" ]; then
    sed -i "s/version=\"[0-9]\+\.[0-9]\+\.[0-9]\+\.qualifier\"/version=\"${QUALIFIER_VERSION}\"/" "$FEATURE_XML"
fi

# 3. 更新 category.xml
echo "📝 更新 category.xml..."
CATEGORY_XML="repository/category.xml"
if [ -f "$CATEGORY_XML" ]; then
    sed -i "s/version=\"[0-9]\+\.[0-9]\+\.[0-9]\+\.qualifier\"/version=\"${QUALIFIER_VERSION}\"/" "$CATEGORY_XML"
fi

# 4. 更新所有插件的 MANIFEST.MF
echo "📝 更新所有插件的 MANIFEST.MF..."
find plugins -name "MANIFEST.MF" | while read manifest; do
    echo "   - $manifest"
    sed -i "s/Bundle-Version: [0-9]\+\.[0-9]\+\.[0-9]\+\.qualifier/Bundle-Version: ${QUALIFIER_VERSION}/" "$manifest"
done

# 5. 更新所有模块的 pom.xml（如果存在）
echo "📝 更新模块 pom.xml..."
for pom in features/*/pom.xml plugins/*/pom.xml repository/pom.xml; do
    if [ -f "$pom" ]; then
        echo "   - $pom"
        sed -i "0,/<version>.*<\/version>/s/<version>.*<\/version>/<version>${SNAPSHOT_VERSION}<\/version>/" "$pom"
    fi
done

echo ""
echo "✅ 版本更新完成！"
echo ""
echo "📋 下一步操作："
echo "   1. 检查修改: git diff"
echo "   2. 本地构建测试: mvn clean verify"
echo "   3. 提交更改: git add . && git commit -m 'chore: bump version to ${NEW_VERSION}'"
echo "   4. 推送到远程: git push origin main"
echo "   5. 创建标签: git tag v${NEW_VERSION} && git push origin v${NEW_VERSION}"
echo ""

