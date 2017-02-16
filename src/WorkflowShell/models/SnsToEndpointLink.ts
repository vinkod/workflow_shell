export default class SnsToEndpointLink {
  public readonly snsArn: string;
  public readonly endpoint: string;

  constructor(sns: string, lambda: string) {
    this.snsArn = sns;
    this.endpoint = lambda;
  }

  toString() {
    return `${this.snsArn} -> ${this.endpoint}`;
  }
}
