// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Importing the Uniswap v2 Router interface
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";

contract Swapper {
    // Interface for the Uniswap v2 Router
    IUniswapV2Router02 private uniswapRouter;

    constructor(address _routerAddress) {
        uniswapRouter = IUniswapV2Router02(_routerAddress);
    }

    // Swaps an exact amount of ETH for as many output tokens as possible, along the route determined by the path.
    // The first element of path must be WETH, the last is the output token,
    // and any intermediate elements represent intermediate pairs to trade through (if, for example, a direct pair does not exist).
    function swapETHForTokens(address _tokenOut, address _receiver) external payable {
        address[] memory path = new address[](2);
        path[0] = uniswapRouter.WETH();
        path[1] = _tokenOut;

        // Note: deadline is used to ensure the transaction is not mined in a block that is too far in the future or the past,
        // which would result in the transaction being reverted. You can set it to the current time plus some amount of time to wait.
        // Here we set the deadline to current block timestamp + 300 seconds (5 minutes).
        uint256 deadline = block.timestamp + 300;

        // The swapExactETHForTokens function is called from the Uniswap v2 Router, where msg.value is the amount of ETH to be swapped,
        // path is the trading path to be used, and to (_receiver) is the address that will receive the output tokens.
        uniswapRouter.swapExactETHForTokens{ value: msg.value }(0, path, _receiver, deadline);
    }

    // To receive ETH when swapping tokens
    receive() external payable {}
}
