import { createElement } from 'lwc';
import LightningMessageChannelImplement1 from 'c/lightningMessageChannelImplement1';

describe('c-lightning-message-channel-implement1', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('TODO: test case generated by CLI command, please fill in test logic', () => {
        // Arrange
        const element = createElement('c-lightning-message-channel-implement1', {
            is: LightningMessageChannelImplement1
        });

        // Act
        document.body.appendChild(element);

        // Assert
        // const div = element.shadowRoot.querySelector('div');
        expect(1).toBe(1);
    });
});