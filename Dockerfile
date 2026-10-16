FROM eclipse-temurin:21-jdk AS build

WORKDIR /workspace
ENV NODE_OPTIONS="--max-old-space-size=4096"
COPY . .
RUN chmod +x ./gradlew \
    && ./gradlew --no-daemon --max-workers=2 \
        -Dorg.gradle.jvmargs="-Xmx3g -XX:MaxMetaspaceSize=1g -Dfile.encoding=UTF-8" \
        -Pkotlin.compiler.execution.strategy=in-process \
        :cmp-web:jsBrowserDistribution \
    && test -f cmp-web/build/dist/js/productionExecutable/index.html \
    && test -s cmp-web/build/dist/js/productionExecutable/cmp-web.js

FROM nginx:alpine

COPY --from=build /workspace/cmp-web/build/dist/js/productionExecutable/ /usr/share/nginx/html/
COPY nginx-mifos.conf /etc/nginx/nginx.conf

EXPOSE 8178
