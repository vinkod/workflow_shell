export default class ClientConfiguration {
  public readonly configurationId: string;
  public readonly accountId: string;
  public readonly name: string;
  public readonly source: string;
  public readonly deliveryMethodName: string;
  public readonly deliveryMethodId: string;
  public readonly links: string[];
  constructor(
    configurationId: string,
    accountId: string,
    name: string,
    source: string,
    deliveryMethodName: string,
    deliveryMethodId: string,
    links: string[]) {

    this.configurationId = configurationId;
    this.accountId = accountId;
    this.name = name;
    this.source = source;
    this.deliveryMethodName = deliveryMethodName;
    this.deliveryMethodId = deliveryMethodId;
    this.links = links;
  }
}

export class ClientConfigurationBuilder {
  public configurationId: string;
  public accountId: string;
  public name: string;
  public source: string;
  public deliveryMethodName: string;
  public deliveryMethodId: string;
  public links: string[];

  setConfigurationId(configurationId: string): ClientConfigurationBuilder {
    this.configurationId = configurationId;
    return this;
  }
  setAccountId(accountId: string): ClientConfigurationBuilder {
    this.accountId = accountId;
    return this;
  }
  setName(name: string): ClientConfigurationBuilder {
    this.name = name;
    return this;
  }
  setSource(source: string): ClientConfigurationBuilder {
    this.source = source;
    return this;
  }
  setDeliveryMethodName(deliveryMethodName: string): ClientConfigurationBuilder {
    this.deliveryMethodName = deliveryMethodName;
    return this;
  }
  setDeliveryMethodId(deliveryMethodId: string): ClientConfigurationBuilder {
    this.deliveryMethodId = deliveryMethodId;
    return this;
  }
  setLinks(links: string[]): ClientConfigurationBuilder {
    this.links = links;
    return this;
  }

  build(): ClientConfiguration {
    return new ClientConfiguration(
      this.configurationId,
      this.accountId,
      this.name,
      this.source,
      this.deliveryMethodName,
      this.deliveryMethodId,
      this.links);
  }
}