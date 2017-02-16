export default class HelpItem {
  public readonly description: string;
  public readonly short: string;
  public readonly long: string;

  constructor(short: string, long: string, description: string) {
    this.description = description;
    this.short = short;
    this.long = long;
  }

  toString() {
    return `-${this.short}\t\t--${this.long}\t\t${this.description}`;
  }
}
