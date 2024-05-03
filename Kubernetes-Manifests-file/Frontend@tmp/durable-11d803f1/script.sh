
                        git config user.email "deepnabha20@gmail.com"
                        git config user.name "Pardeep32"
                        BUILD_NUMBER=${BUILD_NUMBER}
                        echo $BUILD_NUMBER
                        imageTag=$(grep -oP '(?<=frontend:)[^ ]+' deployment.yaml)
                        echo $imageTag
                        sed -i "s/${AWS_ECR_REPO_NAME}:${imageTag}/${AWS_ECR_REPO_NAME}:${BUILD_NUMBER}/" deployment.yaml
                        git add deployment.yaml
                        git add ../../Application-Code/frontend/.scannerwork/
                        git add ../../Application-Code/frontend/dependency-check-report.xml
                        git add ../../Application-Code/frontend/trivyfs.txt
                        git add ../Frontend@tmp/
                        git commit -m "Update deployment Image to version ${BUILD_NUMBER}"
                        git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:master
                    