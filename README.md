# deploy4me

Take payback on the generalized frontrunners by making them get their hands dirty instead of you. As illogical regulatory regimes continue to infringe on software developers first amendment rights, we turn to the technology to uphold the rights that our governments will not.

This repo demonstrates a way to get bytecode onto the ethereum network without directly deploying it yourself.

## How it works

The mempool is full of sophisticated players. Most of them are there trying to farm users for their mistakenly set slippage parameters, but some are there to capitalize on _any_ profitable transactions. The specific class of actor I will focus on here is the "generalized frontrunner". These actors run a fairly simple strategy, for every transaction that hits the mempool, attempt to simulate that transaction while replacing the `msg.sender` with their own address and see if their balance has increased after that transaction. If the balance does increase, then "frontrun" the original transaction and be the one to take advantage of that profitable transaction.

So the trick to do this with a deploy transaction is simple. Just make the transaction that deploys the transaction also reward the deployer with some reward. Then float this transaction into the mempool and allow the frontrunners to gobble it up.

