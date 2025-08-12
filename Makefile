include .env

.PHONY: all clean

install:
	forge install cyfrin/foundry-devops
	forge install openzeppelin/openzeppelin-contracts@v4.8.3
	forge install smartcontractkit/chainlink-brownie-contracts

deploy-monad:
	forge script script/DeployDSC.s.sol:DeployDSC --broadcast \
    --rpc-url ${MONAD_RPC_URL} --private-key ${PRIVATE_KEY_MAIN} \
    --verify --verifier sourcify --verifier-url https://sourcify-api-monad.blockvision.org \
    -vvv

deploy-nexus:
	forge script script/DeployDSC.s.sol:DeployDSC --broadcast \
    --rpc-url ${NEXUS_RPC_URL} --private-key ${PRIVATE_KEY_NEXUS} \
    --verify --verifier blockscout --verifier-url 'https://testnet3.explorer.nexus.xyz/api/' -vv
