# kubeconコマンドチートシート


```bash
$ kubectl get ns|grep yan|awk '{print $1}'| xargs -I {} kubectl -n {} get all
$ kubectl get all -n --all-namespaces
$ kubectl get <リソース名> --output yaml | less
$ kubectl get pod myapp --output yaml --namespace default > pod.yam
$ diff pod.yaml myapp.yam
$ kubectl get pod myapp --output json --namespace default | jq '.spec.containers[].image'  "blux2/hello-server:1.0"
$ kubectl get pod <Pod名> --output jsonpath='{.spec.containers[].image
$ kubectl logs myapp --container hello-serve
$ kubectl logs deploy/hello-server
$ kubectl get pod --selector app=myapp
$ kubectl logs --selector app=myapp
# デバック用サイドカーコンテナ立ち上げ
### デバッグしたくても必要なツーツールが入っていないどころかシェルすら入っておらず、何もできない場合、デバッグ用コンテナを起動することで、多様なデバッグツールを利用できるようになる
$ kubectl debug --stdin --tty <デバッグ対象Pod名> --image=<デバッグ用コンテナのimage> --target=<デバッグ対象のコンテナ
```
