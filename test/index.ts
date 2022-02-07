import { expect } from "chai";
import { ethers } from "hardhat";

describe("Article", () => {
  it("Can create new article", async () => {
    const ArticlesContract = await ethers.getContractFactory("Articles");
    const articlesContract = await ArticlesContract.deploy();
    await articlesContract.deployed();

    let articles = await articlesContract.getArticlesByAuthor();
    expect(articles.length).equal(0);

    const title = "My first article";
    const content = "This is first post.";

    await articlesContract.createArticle(title, content);

    const createdArticle = await articlesContract.getArticle(0);
    expect(createdArticle.title).equal(title);
    expect(createdArticle.content).equal(content);

    await articlesContract.createArticle(
      "My Second article",
      "This is second post"
    );

    articles = await articlesContract.getArticlesByAuthor();
    expect(articles.length).equal(2);
  });
});
