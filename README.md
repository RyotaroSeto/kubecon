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
$ kubectl config get-contexts                          # コンテキストのリストを表示
$ kubectl config current-context                       # 現在のコンテキストを表示
```

### デバック用サイドカーコンテナ立ち上げ
デバッグしたくても必要なツーツールが入っていないどころかシェルすら入っておらず、何もできない場合、デバッグ用コンテナを起動することで、多様なデバッグツールを利用できるようになる
```bash
$ kubectl debug --stdin --tty <デバッグ対象Pod名> --image=<デバッグ用コンテナのimage> --target=<デバッグ対象のコンテナ>
$ kubectl debug --stdin --tty myapp image=curlimages/curl:8.4.0 --target=helloserver -- sh
$ curl localhost:8080
```

### コンテナを即時に実行
```bash
$ kubectl run <Pod名> --image=<イメージ名>
# --rm:実行が完了したらPodを削除 --stfin(-i): オプションで標準入力に渡す --tty(-t): オプションで擬似端末を割り当てる  
$ kubectl run busybox --image=busybox:1.36.1 --rm --stdin --tty --restart=Never --command -- nslookup google.com
```

### コンテナにログインしてデバッグ
```bash
# コンテナにログイン用Pod作成
$ kubectl run curlpod --image=curlimages/curl:8.4.0 --command --bin/sh -c "while true; do sleep initify; done;"
# podのIP確認
$ kubectl get pod myapp --output wide
# ログイン用Podにログイン
$ kubectl exec --stdin --tty curlpod -- /bin/sh
# ログイン後疎通確認
$ curl <myapp PodのIP>:8080
```

### port-forwardでアプリケーションにアクセス
```bash
$ kubectl portforward <Pod名> <転送先ポート番号>:<転送元ポート番号>
$ kubectl portforward myapp 5555:8080
$ curl localhost:5555
```

https://kubernetes.io/ja/docs/reference/kubectl/cheatsheet/
