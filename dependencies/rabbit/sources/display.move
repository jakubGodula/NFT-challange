module rabbit::display {
    use sui::display::Display;

    public fun feed_rabbit<T: key>(_display: &mut Display<T>) {
        // Mock implementation
    }
}
