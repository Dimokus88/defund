#!/bin/bash
echo ================================================================================
echo ================================================================================
echo ===========██████╗░██╗███╗░░░███╗░█████╗░██╗░░██╗██╗░░░██╗░██████╗==============
echo ===========██╔══██╗██║████╗░████║██╔══██╗██║░██╔╝██║░░░██║██╔════╝==============
echo ===========██║░░██║██║██╔████╔██║██║░░██║█████═╝░██║░░░██║╚█████╗░==============
echo ===========██║░░██║██║██║╚██╔╝██║██║░░██║██╔═██╗░██║░░░██║░╚═══██╗==============
echo ===========██████╔╝██║██║░╚═╝░██║╚█████╔╝██║░╚██╗╚██████╔╝██████╔╝==============
echo ===========╚═════╝░╚═╝╚═╝░░░░░╚═╝░╚════╝░╚═╝░░╚═╝░╚═════╝░╚═════╝░==============
echo ================================================================================
echo ============================= https://t.me/Dimokus =============================
echo ================================================================================
sleep 5
echo ================================================================================
echo ================================================================================
echo ██████╗░░█████╗░░██╗░░░░░░░██╗███████╗██████╗░███████╗██████╗░  ██████╗░██╗░░░██╗
echo ██╔══██╗██╔══██╗░██║░░██╗░░██║██╔════╝██╔══██╗██╔════╝██╔══██╗  ██╔══██╗╚██╗░██╔╝
echo ██████╔╝██║░░██║░╚██╗████╗██╔╝█████╗░░██████╔╝█████╗░░██║░░██║  ██████╦╝░╚████╔╝░
echo ██╔═══╝░██║░░██║░░████╔═████║░██╔══╝░░██╔══██╗██╔══╝░░██║░░██║  ██╔══██╗░░╚██╔╝░░
echo ██║░░░░░╚█████╔╝░░╚██╔╝░╚██╔╝░███████╗██║░░██║███████╗██████╔╝  ██████╦╝░░░██║░░░
echo ╚═╝░░░░░░╚════╝░░░░╚═╝░░░╚═╝░░╚══════╝╚═╝░░╚═╝╚══════╝╚═════╝░  ╚═════╝░░░░╚═╝░░░
sleep 1
echo ====================░█████╗░██╗░░██╗░█████╗░░██████╗██╗░░██╗=====================
echo ====================██╔══██╗██║░██╔╝██╔══██╗██╔════╝██║░░██║=====================
echo ====================███████║█████═╝░███████║╚█████╗░███████║=====================
echo ====================██╔══██║██╔═██╗░██╔══██║░╚═══██╗██╔══██║=====================
echo ====================██║░░██║██║░╚██╗██║░░██║██████╔╝██║░░██║=====================
echo ====================╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚═╝░░╚═╝=====================
sleep 10

binary="defundd"
folder=".defund"
denom="ufetf"
chain="defund-private-1"
gitrep="https://github.com/defund-labs/defund"
gitfold="defund"
vers="v0.0.2"
genesis="https://raw.githubusercontent.com/defund-labs/defund/v0.0.2/testnet/private/genesis.json"
addrbook="https://raw.githubusercontent.com/sowell-owen/addrbooks/main/defund/addrbook.json"
PEER="019c0f713f1a3ff1e0b8ec87e40b98580f7311f7@51.91.208.59:26656,111ba4e5ae97d5f294294ea6ca03c17506465ec5@208.68.39.221:26656,f114c02efc5aa7ee3ee6733d806a1fae2fbfb66b@5.189.178.222:46656,8980faac5295875a5ecd987a99392b9da56c9848@85.10.216.151:26656,3c3170f0bcbdcc1bef12ed7b92e8e03d634adf4e@65.108.103.236:27656"

SYNH(){
	if [[ -z `ps -o pid= -p $nodepid` ]]
	then
		echo ===================================================================
		echo ===Нода не работает, перезапускаю...Node not working, restart...===
		echo ===================================================================
		nohup  $binary start   > /dev/null 2>&1 & nodepid=`echo $!`
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
	echo =====Ваш адрес =====
	echo ===Your address ====
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

#*******************ФУНКЦИЯ РАБОЧЕГО РЕЖИМА НОДЫ|*************************
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
	cat /root/$folder/config/priv_validator_key.json
	sleep 20
	echo =================================================
	echo ===============Balance check...==================
	echo =================================================
	echo =================================================
	echo =============Проверка баланса...=================
	echo =================================================
	
	#+++++++++++++++++++++++++++АВТОДЕЛЕГИРОВАНИЕ++++++++++++++++++++++++
	balance=`$binary q bank balances $address -o json | jq -r .balances[].amount `
	balance=`printf "%.f \n" $balance`
	echo =========================
	echo ==Ваш баланс: $balance ==
	echo = Your balance $balance =
	echo =========================
	sleep 5
	if [[ `echo $balance` -gt 1000000 ]]
	then
		echo ======================================================================
		echo ============Balance = $balance . Delegate to validator================
		echo ======================================================================
		echo ======================================================================
		echo =============Баланс = $balance . Делегирую валидатору=================
		echo ======================================================================
		stake=$(($balance-500000))
		(echo ${PASSWALLET}) | $binary tx staking delegate $valoper ${stake}`echo $denom` --from $address --chain-id $chain --fees 5555$denom -y
		sleep 5
		stake=0
		balance=0
	fi
	#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	
	#===============СБОР НАГРАД И КОМИССИОННЫХ===================
	reward=`$binary query distribution rewards $address $valoper -o json | jq -r .rewards[].amount`
	reward=`printf "%.f \n" $reward`
	echo ==============================
	echo ==Ваши награды: $reward $denom==
	echo ===Your reward $reward $denom===
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
		(echo ${PASSWALLET}) | $binary tx distribution withdraw-rewards $valoper --from $address --fees 5555$denom --commission -y
		reward=0
		sleep 5
	fi
	#============================================================
	synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
	
	#--------------------------ВЫХОД ИЗ ТЮРЬМЫ--------------------------
	jailed=`$binary query staking validator $valoper -o json | jq -r .jailed`
	while [[  $jailed == true ]] 
	do
		echo ==Внимание! Валидатор в тюрьме, попытка выхода из тюрьмы произойдет через 30 минут==
		echo =Attention! Validator in jail, attempt to get out of jail will happen in 30 minutes=
		sleep 30m
		(echo ${PASSWALLET}) | $binary tx slashing unjail --from $address --chain-id $chain --fees 5000$denom -y
		sleep 10
		jailed=`$binary query staking validator $valoper -o json | jq -r .jailed`
	done
	#-------------------------------------------------------------------
done
}
#************************************************************************************************************************

#======================================================== КОНЕЦ БЛОКА ФУНКЦИЙ ====================================================================================

ver="1.18.1" && \
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" && \
sudo rm -rf /usr/local/go && \
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" && \
rm "go$ver.linux-amd64.tar.gz" && \
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile && \
source $HOME/.bash_profile && \
go version
git clone $gitrep && cd $gitfold
echo $vers
sleep 5
git checkout $vers
make install
mv ~/go/bin/$binary /usr/local/bin/$binary

$binary version


echo 'export my_root_password='${my_root_password}  >> $HOME/.bashrc
echo 'export MONIKER='${MONIKER} >> $HOME/.bashrc
echo 'export MNEMONIC='${MNEMONIC} >> $HOME/.bashrc
echo 'export WALLET_NAME='${WALLET_NAME} >> $HOME/.bashrc
echo 'export PASSWALLET='${PASSWALLET} >> $HOME/.bashrc
echo 'export LINK_SNAPSHOT='${LINK_SNAPSHOT} >>  $HOME/.bashrc
echo 'export SNAP_RPC='${SNAP_RPC} >>  $HOME/.bashrc
echo 'export LINK_KEY='${LINK_KEY} >>  $HOME/.bashrc

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
$binary version --long | head
sleep 10
#=======init ноды==========
echo =INIT=
$binary init "$MONIKER" --chain-id $chain
sleep 10
#==========================

#===========ДОБАВЛЕНИЕ КОШЕЛЬКА============
(echo "${MNEMONIC}"; echo ${PASSWALLET}; echo ${PASSWALLET}) | $binary keys add ${WALLET_NAME} --recover
address=`(echo ${PASSWALLET}) | $(which $binary) keys show $WALLET_NAME -a`
valoper=`(echo ${PASSWALLET}) | $(which $binary) keys show $WALLET_NAME  --bech val -a`
echo =====Ваш адрес =====
echo ===Your address ====
echo $address
echo ==========================
echo =====Your valoper=====
echo ======Ваш valoper=====
echo $valoper
echo ===========================
#==================================

wget -O $HOME/$folder/config/genesis.json $genesis
sha256sum ~/$folder/config/genesis.json
cd && cat $folder/data/priv_validator_state.json
#==========================
rm $HOME/$folder/config/addrbook.json
wget -O $HOME/$folder/config/addrbook.json $addrbook

# ------ПРОВЕРКА НАЛИЧИЯ priv_validator_key--------
wget -O /var/www/html/priv_validator_key.json ${LINK_KEY}
file=/var/www/html/priv_validator_key.json

source $HOME/.bashrc
#---проверка наличия пользовательского priv_validator_key---
if  [[ -f "$file" ]]
then
	cd /
	echo ==========priv_validator_key found==========
	echo ========Обнаружен priv_validator_key========
	cp /var/www/html/priv_validator_key.json /root/$folder/config/
	echo ========Validate the priv_validator_key.json file=========
	echo ==========Сверьте файл priv_validator_key.json============
	cat /root/$folder/config/priv_validator_key.json
	sleep 5

else
	echo =====================================================================
	echo =========== priv_validator_key not found, making a backup ===========
	echo =====================================================================
	echo =====================================================================
	echo ====== priv_validator_key не обнаружен, создаю резервную копию ======
	echo =====================================================================
	sleep 2
	cp /root/$folder/config/priv_validator_key.json /var/www/html/
	echo =================================================================================================================================================
	echo ======== priv_validator_key has been created! Go to the SHELL tab and run the command: cat /root/$folder/config/priv_validator_key.json =========
	echo ===== Save the output to a .json file on google drive. Place a direct link to download the file in the manifest and update the deployment! ======
	echo ==========================================================Work has been suspended!===============================================================
	echo =================================================================================================================================================
	echo ========== priv_validator_key создан! Перейдите во вкладку SHELL и выполните команду: cat /root/$folder/config/priv_validator_key.json ==========
	echo == Сохраните вывод в файл с расширением .json на google диск. Разместите прямую ссылку на скачивание файла в манифесте и обновите деплоймент! ===
	echo ==========================================================Работа приостановлена!=================================================================
	
	sleep infinity
fi
# -----------------------------------------------------------

$binary config chain-id $chain

$binary config keyring-backend os

sleep 10
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025$denom\"/;" ~/$folder/config/app.toml

pruning="custom" && \
pruning_keep_recent="100" && \
pruning_keep_every="0" && \
pruning_interval="50" && \
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/$folder/config/app.toml && \
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/$folder/config/app.toml && \
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/$folder/config/app.toml && \
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/$folder/config/app.toml

peers="$PEER"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/$folder/config/config.toml

indexer="null" && \
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/$folder/config/config.toml

snapshot_interval="0" && \
sed -i.bak -e "s/^snapshot-interval *=.*/snapshot-interval = \"$snapshot_interval\"/" ~/$folder/config/app.toml

# ||||||||||||||||||||||||||||||||||||||||||||||||Backup||||||||||||||||||||||||||||||||||||||||||||||||||||||
#=======Загрузка снепшота блокчейна===
if [[ -n $LINK_SNAPSHOT ]]
then
	cd /root/$folder/
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
s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"\"|" $HOME/$folder/config/config.toml
echo RPC
sleep 5
fi
#================================================
# |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
source $HOME/.bashrc
#===========ЗАПУСК НОДЫ============
echo =Run node...=
nohup $binary start  > /dev/null 2>&1 & nodepid=`echo $!`
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
	val=`$binary query staking validator $valoper -o json | jq -r .description.moniker`
	echo $val
	synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
	echo $synh
	source $HOME/.bashrc
	if [[ -z "$val" ]]
	then
		echo =Создание валидатора... Creating a validator...=
		(echo ${PASSWALLET}) | $binary tx staking create-validator --amount="1000000$denom" --pubkey=$($binary tendermint show-validator) --moniker="$MONIKER"	--chain-id="$chain"	--commission-rate="0.10" --commission-max-rate="0.20" --commission-max-change-rate="0.01" --min-self-delegation="1000000" --gas="auto"	--from="$address" --fees="5550$denom" -y
		echo 'true' >> /var/validator
		val=`$binary query staking validator $valoper -o json | jq -r .description.moniker`
		echo $val
	else
		val=`$binary query staking validator $valoper -o json | jq -r .description.moniker`
		echo $val
		MONIKER=`echo $val`
		WORK
	fi
done