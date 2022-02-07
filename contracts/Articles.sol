//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Articles {
  struct Article {
    address author;
    string title;
    string content;
    uint256 createdAt;
    uint256 updatedAt;
  }

  Article[] private articles;

  mapping(uint256 => address) private articleIdToAuthor;
  mapping(address => uint256) private authorArticleCount;

  event ArticleCreated(uint256 articleId, string title, string content);

  function createArticle(string memory _title, string memory _content) public {
    articles.push(
      Article(msg.sender, _title, _content, block.timestamp, block.timestamp)
    );
    uint256 articleId = articles.length;
    articleIdToAuthor[articleId] = msg.sender;
    authorArticleCount[msg.sender]++;
    emit ArticleCreated(articleId, _title, _content);
  }

  function getArticlesByAuthor() public view returns (Article[] memory) {
    Article[] memory result = new Article[](authorArticleCount[msg.sender]);
    uint256 counter = 0;
    for (uint256 i = 0; i < articles.length; i++) {
      if (articleIdToAuthor[i] == msg.sender) {
        result[counter] = articles[i];
        counter++;
      }
    }
    return result;
  }

  function getArticle(uint256 articleId) public view returns (Article memory) {
    return articles[articleId];
  }
}
