// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedBank {
    // Her kullanıcının bakiyesini takip etmek için mapping
    mapping(address => uint256) private balances;

    // Yatırımları loglamak için event
    event Deposit(address indexed user, uint256 amount);

    // Çekimleri loglamak için event
    event Withdrawal(address indexed user, uint256 amount);

    // Bankaya Ether yatırmak için fonksiyon
    function deposit() external payable {
        // Yatırım miktarının sıfırdan büyük olduğundan emin ol
        require(msg.value > 0, "Deposit amount must be greater than zero");

        // Kullanıcının bakiyesini güncelle
        balances[msg.sender] += msg.value;

        // Yatırım event'ini tetikle
        emit Deposit(msg.sender, msg.value);
    }

    // Bankadan Ether çekmek için fonksiyon
    function withdraw(uint256 _amount) external {
        // Çekilecek miktarın kullanıcının bakiyesinden büyük veya eşit olduğundan emin ol
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Kullanıcının bakiyesini güncelle
        balances[msg.sender] -= _amount;

        // Ether'i kullanıcıya transfer et
        payable(msg.sender).transfer(_amount);

        // Çekim event'ini tetikle
        emit Withdrawal(msg.sender, _amount);
    }

    // Kullanıcının bakiyesini kontrol etmek için fonksiyon
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}

