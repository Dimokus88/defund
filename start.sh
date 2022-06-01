#!/bin/bash

#====================================
#=============by Dimokus=============
#========https://t.me/Dimokus========
#====================================
#======================================================== НАЧАЛО БЛОКА ФУНКЦИЙ ========================================================
#||||||||ФУНКЦИЯ СИНХРОНИЗАЦИИ||||||||
SYNH(){
	if [[ -z `ps -o pid= -p $nodepid` ]]
	then
		echo ===================================================================
		echo ===Нода не работает, перезапускаю...Node not working, restart...===
		echo ===================================================================
		nohup  $(which defundd) start   > /dev/null 2>&1 & nodepid=`echo $!`
		echo $nodepid
		sleep 5
		curl -s localhost:26657/status
		synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
		echo $synh
		source $HOME/.bashrc
	else
		echo =================================
		echo ===Нода работает.Node working.===
		echo =================================
		curl -s localhost:26657/status
		synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
		echo $nodepid
		echo $synh
		source $HOME/.bashrc
	fi
	echo =====Ваш адрес defund=====
	echo ===Your address defund====
	echo $address
	echo ==========================
	echo =====Your valoper=====
	echo ======Ваш valoper=====
	echo $valoper
	echo ===========================
	date
	source $HOME/.bashrc

}
#||||||||||||||||||||||||||||||||||||||

#||||||||ФУНКЦИЯ РАБОЧЕГО РЕЖИМА НОДЫ||||||||

WORK (){
while [[ $synh == false ]]
do		
	sleep 5m
	date
	SYNH
	echo =======================================================================
	echo =============Check if the validator keys are correct! =================
	echo =======================================================================
	echo =======================================================================
	echo =============Проверьте корректность ключей валидатора!=================
	echo =======================================================================
	cat /root/.defund/config/priv_validator_key.json
	sleep 20
	echo =================================================
	echo ===============Balance check...==================
	echo =================================================
	echo =================================================
	echo =============Проверка баланса...=================
	echo =================================================
	balance=`curl -s https://defund.api.explorers.guru/api/accounts/$address/balance | jq .spendable.amount`
	echo Ваш баланс: $balance ufetf
	sleep 5
	if [[ `echo $balance` -gt 1000000 ]]
	then
		echo ======================================================================
		echo ============Balance = $balance . Delegate to validator================
		echo ======================================================================
		echo ======================================================================
		echo =============Баланс = $balance . Делегирую валидатору=================
		echo ======================================================================
		let stake=($balance-500000)
		(echo ${PASSWALLET}) | defundd tx staking delegate $valoper ${stake}ufetf --from $address --chain-id defund-private-1 --fees 5000ufetf -y
		sleep 5
		balance=0
	else
		echo ======================================================================
		echo ==================Insufficient balance to delegate====================
		echo ======================================================================
		echo ======================================================================
		echo ==============Недостаточный баланс для делегирования==================
		echo ======================================================================
	fi
	#===============СБОР НАГРАД И КОМИССИОННЫХ===================
	reward==`curl -s https://sei.api.explorers.guru/api/accounts/$address/balance | jq .spendable.reward`
	echo ==============================
	echo ==Ваши награды: $reward usei==
	echo ===Your reward $reward usei===
	echo ==============================
	sleep 5
		if [[ `echo $reward` -gt 1000000 ]]
	then
		echo =============================================================
		echo ============Rewards discovered, collecting...================
		echo =============================================================
		echo =============================================================
		echo =============Обнаружены награды, собираю...==================
		echo =============================================================
		(echo ${PASSWALLET}) | defundd tx distribution withdraw-rewards $valoper --from $address --fees 5000ufetf --commission -y
		reward=0
		sleep 5
	fi
	#============================================================
	synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
	jailed=`curl -s https://defund.api.explorers.guru/api/validators/$valoper | jq -r .jailed`
	while [[  $jailed == true ]] 
	do
		echo ==Внимание! Валидатор в тюрьме, попытка выхода из тюрьмы произойдет через 30 минут==
		echo =Attention! Validator in jail, attempt to get out of jail will happen in 30 minutes=
		sleep 30m
		(echo ${PASSWALLET}) | defundd tx slashing unjail --from $address --chain-id defund-private-1 --fees 5000ufetf -y
		sleep 10
		jailed=`curl -s https://defund.api.explorers.guru/api/validators/$valoper | jq -r .jailed`
	done
done
}
#||||||||||||||||||||||||||||||||||||||

#======================================================== КОНЕЦ БЛОКА ФУНКЦИЙ ========================================================

echo 'export my_root_password='${my_root_password}  >> $HOME/.bashrc
echo 'export MONIKER='${MONIKER} >> $HOME/.bashrc
echo 'export MNEMONIC='${MNEMONIC} >> $HOME/.bashrc
echo 'export WALLET_NAME='${WALLET_NAME} >> $HOME/.bashrc
echo 'export PASSWALLET='${PASSWALLET} >> $HOME/.bashrc
echo 'export LINK_SNAPSHOT='${LINK_SNAPSHOT} >>  $HOME/.bashrc
echo 'export SNAP_RPC='${SNAP_RPC} >>  $HOME/.bashrc
echo 'export LINK_KEY='${LINK_KEY} >>  $HOME/.bashrc
echo 'export val='${val} >>  $HOME/.bashrc
echo 'export valoper='${valoper} >>  $HOME/.bashrc
echo 'export address='${address} >>  $HOME/.bashrc
echo 'export synh='${synh} >>  $HOME/.bashrc
PASSWALLET=$(openssl rand -hex 4)
WALLET_NAME=$(goxkcdpwgen -n 1)
echo ${PASSWALLET}
echo ${WALLET_NAME}
sleep 5
source $HOME/.bashrc

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
(echo ${my_root_password}; echo ${my_root_password}) | passwd root
service ssh restart
service nginx start
sleep 5

#=======init ноды==========
echo =INIT Defund=
defundd init "$MONIKER" --chain-id=defund-private-1
sleep 10
#==========================

#===========ДОБАВЛЕНИЕ КОШЕЛЬКА============
(echo "${MNEMONIC}"; echo ${PASSWALLET}; echo ${PASSWALLET}) | defundd keys add ${WALLET_NAME} --recover
address=`(echo ${PASSWALLET}) | $(which defundd) keys show $WALLET_NAME -a`
valoper=`(echo ${PASSWALLET}) | $(which defundd) keys show $WALLET_NAME  --bech val -a`
echo =====Ваш адрес defund=====
echo ===Your address defund====
echo $address
echo ==========================
echo =====Your valoper=====
echo ======Ваш valoper=====
echo $valoper
echo ===========================
#==================================

wget -O $HOME/.defund/config/genesis.json "https://raw.githubusercontent.com/schnetzlerjoe/defund/main/testnet/private/genesis.json"
sha256sum ~/.defund/config/genesis.json
cd && cat .defund/data/priv_validator_state.json
#==========================
rm $HOME/.defund/config/addrbook.json
wget -O $HOME/.defund/config/addrbook.json ${LINK_ADDRBOOK}

# ------ПРОВЕРКА НАЛИЧИЯ priv_validator_key--------
wget -O /var/www/html/priv_validator_key.json ${LINK_KEY}
file=/var/www/html/priv_validator_key.json

source $HOME/.bashrc
if  [[ -f "$file" ]]
then
	cd /
	echo ==========priv_validator_key found==========
	echo ========Обнаружен priv_validator_key========
	cp /var/www/html/priv_validator_key.json /root/.defund/config/
	echo ========Validate the priv_validator_key.json file=========
	echo ==========Сверьте файл priv_validator_key.json============
	cat /root/.defund/config/priv_validator_key.json
	sleep 5


else
	echo =====================================================================
	echo =========== priv_validator_key not found, making a backup ===========
	echo =====================================================================
	echo =====================================================================
	echo ====== priv_validator_key не обнаружен, создаю резервную копию ======
	echo =====================================================================
	sleep 2
	cp /root/.defund/config/priv_validator_key.json /var/www/html/
	echo =================================================================================================================================================
	echo ======== priv_validator_key has been created! Go to the SHELL tab and run the command: cat /root/.defund/config/priv_validator_key.json =========
	echo ===== Save the output to a .json file on google drive. Place a direct link to download the file in the manifest and update the deployment! ======
	echo ==========================================================Work has been suspended!===============================================================
	echo =================================================================================================================================================
	echo ========== priv_validator_key создан! Перейдите во вкладку SHELL и выполните команду: cat /root/.defund/config/priv_validator_key.json ==========
	echo == Сохраните вывод в файл с расширением .json на google диск. Разместите прямую ссылку на скачивание файла в манифесте и обновите деплоймент! ===
	echo ==========================================================Работа приостановлена!=================================================================
	
	sleep infinity
fi
# ------------------------------------

defundd config chain-id defund-private-1
echo "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\"
sleep 10
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025ufetf\"/;" ~/.defund/config/app.toml

pruning="custom" && \
pruning_keep_recent="100" && \
pruning_keep_every="0" && \
pruning_interval="50" && \
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.defund/config/app.toml && \
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.defund/config/app.toml && \
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.defund/config/app.toml && \
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.defund/config/app.toml


external_address=$(wget -qO- eth0.me)

peers="019c0f713f1a3ff1e0b8ec87e40b98580f7311f7@51.91.208.59:26656,111ba4e5ae97d5f294294ea6ca03c17506465ec5@208.68.39.221:26656,f114c02efc5aa7ee3ee6733d806a1fae2fbfb66b@5.189.178.222:46656,8980faac5295875a5ecd987a99392b9da56c9848@85.10.216.151:26656,3c3170f0bcbdcc1bef12ed7b92e8e03d634adf4e@65.108.103.236:27656"
sed -i.bak -e "s/^external_address *=.*/external_address = \"$external_address:26656\"/; s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.defund/config/config.toml

seeds="8e1590558d8fede2f8c9405b7ef550ff455ce842@51.79.30.9:26656,bfffaf3b2c38292bd0aa2a3efe59f210f49b5793@51.91.208.71:26656,106c6974096ca8224f20a85396155979dbd2fb09@198.244.141.176:26656"
sed -i.bak -e "s/^seeds =.*/seeds = \"$seeds\"/" $HOME/.defund/config/config.toml

indexer="null" && \
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.defund/config/config.toml

snapshot_interval="0" && \
sed -i.bak -e "s/^snapshot-interval *=.*/snapshot-interval = \"$snapshot_interval\"/" ~/.defund/config/app.toml

# ||||||||||||||||||||||||||||||||||||||||||||||||Backup||||||||||||||||||||||||||||||||||||||||||||||||||||||
#=======Загрузка снепшота блокчейна===
if [[ -n $LINK_SNAPSHOT ]]
then
	cd /root/.defund/
	wget -O snap.tar $LINK_SNAPSHOT
	tar xvf snap.tar 
	rm snap.tar
	echo ===============================================
	echo ===== Snapshot загружен!Snapshot loaded! ======
	echo ===============================================
	cd /
fi
#==================================
source $HOME/.bashrc
# ====================RPC======================
if [[ -n $SNAP_RPC ]]
then

LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 1000)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

echo $LATEST_HEIGHT $BLOCK_HEIGHT $TRUST_HASH

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC,$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"| ; \
s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"\"|" $HOME/.defund/config/config.toml
echo RPC
sleep 5
fi
# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
val=`curl -s https://defund.api.explorers.guru/api/validators/$valoper | jq -r .description.moniker`
echo $val
sleep 10
source $HOME/.bashrc

#===========ЗАПУСК НОДЫ============
echo =Run node...=
nohup  $(which defundd) start   > /dev/null 2>&1 & nodepid=`echo $!`
echo $nodepid
source $HOME/.bashrc
echo =Node runing ! =
sleep 20
synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
echo $synh
sleep 2
#==================================
source $HOME/.bashrc
#=========Пока нода не синхронизирована - повторять===========
while [[ $synh == true ]]
do
	sleep 5m
	date
	echo ==============================================
	echo =Нода не синхронизирована! Node is not sync! =
	echo ==============================================
	SYNH
		
done

#=======Если нода синхронизирована - начинаем работу ==========
while	[[ $synh == false ]]
do 	
	sleep 5m
	date
	echo ================================================================
	echo =Нода синхронизирована успешно! Node synchronized successfully!=
	echo ================================================================
	SYNH
	synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
	echo $synh
	source $HOME/.bashrc
	if [[ `echo $val` == null ]]
	then
		echo =Создание валидатора... Creating a validator...=
		(echo ${PASSWALLET}) | defundd tx staking create-validator --amount=2000000ufetf --pubkey=$(defundd tendermint show-validator) --moniker="$MONIKER"	--chain-id=defund-private-1	--commission-rate="0.10" --commission-max-rate="0.20" --commission-max-change-rate="0.01" --min-self-delegation="1000000" --gas="auto"	--from=$address --fees 500ufetf -y
		echo 'true' >> /var/validator
		val=`curl -s https://defund.api.explorers.guru/api/validators/$valoper | jq -r .description.moniker`
	else
		MONIKER=`curl -s https://defund.api.explorers.guru/api/validators/$valoper | jq -r .description.moniker`
		WORK
	fi
done