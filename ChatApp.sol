// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

contract ChatApp {
    // Struct to represent a message
    struct Message {
        address sender;
        string content;
        uint256 timestamp;
    }

    // Mapping to store messages
    mapping(uint256 => Message) public messages;
    uint256 public messageCount;

    // Event to notify when a new message is sent
    event MessageSent(address indexed sender, string content, uint256 timestamp);

    // Function to send a message
    function sendMessage(string memory _content) public {
        require(bytes(_content).length > 0, "Message content cannot be empty");
        
        // Increment message count and store the message
        uint256 messageId = messageCount++;
        messages[messageId] = Message(msg.sender, _content, block.timestamp);
        
        // Emit an event
        emit MessageSent(msg.sender, _content, block.timestamp);
    }

    // Function to get a message by its ID
    function getMessage(uint256 _messageId) public view returns (address, string memory, uint256) {
        require(_messageId < messageCount, "Invalid message ID");
        
        Message memory message = messages[_messageId];
        return (message.sender, message.content, message.timestamp);
    }
}
