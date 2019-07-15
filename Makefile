WAIT := 200s
APPLY = kubectl apply --kubeconfig=$$(kind get kubeconfig-path --name $@) --validate=false --filename
NAME = $$(echo $@ | cut -d "-" -f 2- | sed "s/%*$$//")

nginx nginx%: create-nginx%
	@$(APPLY) https://k8s.io/examples/application/deployment.yaml

create-%:
	@kind create cluster --name $(NAME) --wait $(WAIT)

delete-%:
	@kind delete cluster --name $(NAME)

env-%:
	@kind get kubeconfig-path --name $(NAME)

clean:
	@kind get clusters | xargs -L1 -I% kind delete cluster --name %

list:
	@kind get clusters

.PHONY: nginx  nginx% create-% delete-% env-% clean list
