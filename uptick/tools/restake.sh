#!/bin/bash
for (( ;; )); do
	echo -e "\033[0;32mCollecting rewards!\033[0m"
	echo -e "${PASSWORD}\n"| uptickd tx distribution withdraw-rewards $VALOPER_ADDRESS --from=$WALLET --commission --chain-id=$CHAIN_ID --yes
	echo -e "\033[0;32mWaiting 30 seconds before requesting balance\033[0m"
	sleep 30
	AMOUNT=$(uptickd query bank balances $WALLET_ADDRESS | grep amount | awk '{split($0,a,"\""); print a[2]}')
	echo -e "Your total balance of utrii: \033[0;32m$AMOUNT\033[0m"
	AMOUNT_STRING=$AMOUNT"auptick"
	echo -e "${PASSWORD}\n"| uptickd tx staking delegate $VALOPER_ADDRESS $AMOUNT_STRING --from $WALLET --chain-id $CHAIN_ID --yes
	echo -e "\033[0;32m$AMOUNT_STRING staked! Restarting in 90 sec!\033[0m"
	sleep 90
done
