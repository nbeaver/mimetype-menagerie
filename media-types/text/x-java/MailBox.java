package jsched;

import java.util.LinkedList;
import java.util.Queue;

public class MailBox<T> {
	private final Queue<T> queue = new LinkedList<T>();

	public void addMessage(T msg) {
		try {
			queue.add(msg);
		} catch (IllegalStateException e) {
			// ignore
			System.out.println("warning: ignored message in mailbox " + this);
		}
	}

	public T getMessage() {
		if (queue.isEmpty()) {
			return null;
		} else {
			return queue.remove();
		}

	}
}
