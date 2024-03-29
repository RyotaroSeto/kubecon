# kubecon
kubeconコマンドチートシート


```bash
$ kubectl get ns|grep yan|awk '{print $1}'| xargs -I {} kubectl -n {} get all
$ kubectl get all -n --all-namespaces
```
