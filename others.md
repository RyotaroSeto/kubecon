# ohters
### nodeSelector

node selectorは特定のNodeにのみスケジュールする制御を行う

nodeについているlabelをpodに指定する.

### Node affinity

nodeselectorより柔軟で「可能ならスケジュールする」nodeselectorは存在しないとスケジュールしないため、Node障害に対して弱い

- affinity.nodeAffinity.preferredDuringSchedulingIgnoredDuringExecution
    - 対応するNodeが見つからない場合、適当なNodeにスケジュールする
- affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution
    - 対応するNodeが見つからない場合、Podをスケジュールしない

### PodAffinityとPodAntiAffinity

特定のlabelがついているPodが割り当てられているNodeには同じlabelを持つPodをスケジュールしない

よく使用されるユースケースとしてNode障害に備え「同じアプリケーションを動かしているPodは同じNodeに乗せない」とするルールを追加すること。deploymentで冗長化したpodが同じNodeに乗っているとそのNodeがしたら全Podが全滅するため(pod topologyで回避可能)

### Pod Topology Spread Constraints

podを分散するための設定。topologyKeyを使うことでどのようにPodが分散させるか表現できる

**PodAntiAffinityより柔軟な**ためこっちがおすすめ。topologySpreadConstraintsで設定する

### TaintとToleration

taintはnodeに付与する設定。tolerationはpodに付与する設定。

nodeに付与するtaintをpodが許容するかという概念

あるNodeが特定のPodしかスケジュールしたくない時に使用

ユースケース例:https://kubernetes.io/ja/docs/concepts/scheduling-eviction/taint-and-toleration/

### PriorityClass

PriorityClassを設定することで、Podの起動優先度順位を定義できる

### 水平スケール(HPA)と垂直スケール(VPA)

vpaは自動でresourceのlimitsとrequestsの値を変更してくれる

### PodDisruptionBudgetによる安全なメンテナンス

- k8sを運用する中で、Podが稼働しているノードをメンテナンスしたい場合。その際はkubectl drainを用いて、ノード上のPodを退避させる必要がある。例えばノードが3台あって、レプリカ数2のアプリの場合で、1つのノードに pod2つ配置されている状況でその1つのノードをdrainしたらアプリが停止してしまう。
- 上記の状況を避けるために、`PodDisruptionBudget` を定義することで最低限必要なPod数を1と設定した場合、上記の状況でpod1つはdrainで退避されなくなる。
